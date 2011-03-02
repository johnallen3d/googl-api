require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
 
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'googl-api'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'googl-api'
 
class Test::Unit::TestCase
  def api_key
    'test_key'
  end
   
  def email
    "email"
  end
   
  def password
    "password"
  end
end