#!/usr/bin/env ruby

require_relative './config/environment'

get '/styles/:file.css' do
  scss params[:file].to_sym
end

get '/' do
  haml :index
end

post '/' do
  @inpoetry = params[:inpoetry]
  @outpoetry = params[:inpoetry]
  haml :index
end
