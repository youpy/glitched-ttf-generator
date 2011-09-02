require 'rubygems'
require 'bundler'

Bundler.require

require './glitched_ttf_generator'

run Sinatra::Application
