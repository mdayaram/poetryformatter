#!/usr/bin/env ruby

require_relative './config/environment'

get '/styles/:file.css' do
  scss params[:file].to_sym
end

get '/' do
  @outpoetry = "hi"
  haml :index
end

