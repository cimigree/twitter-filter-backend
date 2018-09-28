# Tweets  on Three Topics API [MicroTweeter](https://microservicetwitter.herokuapp.com/tweets/opensource)

This is a microservice that creates an API for some of the properties on the latest Tweets in English on three topics: open source, health care, and NASA.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Prerequisites For a Mac

Install the following if you haven't already. 

**Install Homebrew**
```      
To avoid RVM installation issues, install Homebrew before RVM. If Homebrew is not installed, install it:
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
You need to use the macOS pre-installed system version of Ruby to install Homebrew. Next up, add a newer version of Ruby using RVM.

**Install RVM, the latest version of Ruby, and the Bundler (to manage the gemfile).**
```
1. Install [RVM](https://rvm.io/) a ruby version manager
--Don't forget to close and reopen the terminal.
2. Install [ruby](https://git-scm.com/downloads).
3. Make sure you have the Ruby gem bundler installed. 
`$ gem install bundler`
```

### Installing
To get this app up and running in a development environment:
```
1. Fork the repo: and then run git clone to use it locally.
2. `cd` into the file.
3. `bundle install` to install the dependencies/ gemfiles
Some gems/ dependencies are :
Sinatra, the Twitter Gem, Active Record, Cross Origin, Rufus Scheduler, SqLite (for development) and PostgreSQL (for deployment, required by Heroku)
```
### Create a Local Database
```

```
### Then
```
5. `ruby twitter_server.rb` to launch in the browser
6. You will need to add the end point /tweets/[topic] in the browser
The topics are: opensource, NASA, or healthcare
```

## Deployment
```

```

## Built With

* [Sinatra](http://www.sinatrarb.com/) - Micro Framework for Ruby
* [Twitter Gem](http://www.rubydoc.info/gems/twitter) - Dependency Management
* [SqLite](https://sqlite.org/)
* [PostgreSQL](https://www.postgresql.org/)

## Author

* **Cindy Green** Other projects can be found at cimigreen.com


## Acknowledgments

* Thank you to John Lange from Academy Pittsburgh from whom I learned how to learn.
* Thanks also to Jean, Lange, Carol Nichols and Jake Goulding who patiently taught us Ruby. Anything wrong here is not their fault.
