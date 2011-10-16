# Load the rails application
require File.expand_path('../application', __FILE__)
require_relative '../vendor/plugins/gdata-ruby-util/lib/gdata.rb'

# Initialize the rails application
Sirius::Application.initialize!
