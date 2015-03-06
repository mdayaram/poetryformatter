require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'haml'
require 'sass'

configure do
  set :server, 'webrick'
  set :app_file, File.expand_path(File.join(File.dirname(__FILE__), "..", "app.rb"))
  set :haml, { :format => :html5 }
end

configure :development do
  set :show_exceptions, true
end

helpers do
  # Add any helpers here.
end
