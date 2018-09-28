require 'sinatra'
require 'json'
require 'active_record'
#require 'dotenv'
require 'rufus-scheduler'
require 'sinatra/cross_origin'
require 'sinatra/reloader' if development?

set :database_file, 'config/database.yml'

#Dotenv.load
#uncomment the above to use in development from .env file for keys, etc.

# ActiveRecord::Base.logger = Logger.new(STDOUT)
# use ActiveRecord::QueryCache
# The above code allows one to see the SQL queries and their results in the logs

configure :production do
  db =  URI.parse(ENV['HEROKU_POSTGRESQL_GREEN_URL'] || 'postgres_database_url')

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
  )
end
#variables above are set by Heroku

# ActiveRecord::Base.establish_connection({
#     database: "tweets_db",
#     adapter: "sqlite3"
# })
# Uncomment the above Code for local development only

ActiveRecord::Schema.define do
     unless ActiveRecord::Base.connection.tables.include? 'tweets'
         #only create the table if it is not already there
    create_table :tweets, force: :cascade do |t|
        t.string :topic
        t.string :profileimage
        t.string :username
        t.string :userscreenname
        t.string :useruri
        t.datetime :createdat
        t.text :fulltext
        t.string :mediaimage
        t.integer   :retweetct
        t.integer :favoritecount
    end
 end
end

class Tweet < ActiveRecord::Base
    validates :fulltext, presence: true, uniqueness: true
    #the above line probably isn't necessary, but it should only save Tweets to the DB if they are not repeated Tweets (through retweets)
 end

 
def client
  require 'twitter'
  @client = Twitter::REST::Client.new do |config| 
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
    config.access_token = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end
end
#cannot get Twitter to read these from the storage on Heroku, sadly



def convert(topic)
    topiclanguage = "#{topic} :lang:en"
@tweets = client.search(topiclanguage).take(15)
#taking more than 10 in case there are repeats
@tweets.each do |t|
    Tweet.create(
    :topic => topic,
    :profileimage =>t.user.profile_image_url_https,
    :username => t.user.name,
    :userscreenname => t.user.screen_name,
    :useruri => t.user.uri,
    :createdat => t.created_at,
    :fulltext => t.full_text,
    :mediaimage => t.media.map(&:media_url),
    :retweetct => t.retweet_count,
    :favoritecount => t.favorite_count)
end
end
#Saving the results of the Twitter API call to database

def sendtweet(newtweet)
client.update(newtweet) 
end



$scheduler = Rufus::Scheduler.new
$scheduler.interval '10m' do
    Tweet.destroy_all
    topics = ["opensource","healthcare", "NASA"]
    topics.each do |t|
        convert(t)
end
end
#Having database update every ten minutes so that it has new Tweets available to show to front-end users

configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = 'http://topicaltweets.s3-website-us-east-1.amazonaws.com'
  end

#obviously, the above is necessary so that the front end can pass a Get request to the API

 get '/tweets/:topic' do 
     content_type :json
     tweets = Tweet.where("topic = ?", params[:topic])
     tweets.to_json
  end
#using topic as an endpoint to get the Tweets by topic based on the search in the front end

post '/tweets/:senttweet' do
  sendtweet(params[:senttweet])
end

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = 'http://topicaltweets.s3-website-us-east-1.amazonaws.com'
    200
  end
#More necessary code to allow for CORS



