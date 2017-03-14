require 'httparty'
require 'pry'

class MyApi
  attr_reader :headers, :url

  def initialize(url)
    @url = url
  end

  def login_as(username)
    @headers = { 'Authorization' => username }
  end

  def list_items
    make_request :get, '/list'
  end

  def add_new_item(title)
    make_request :post, '/list', body: { title: title }
  end

  def mark_complete(title)
    make_request :patch, '/list', query: { title: title }
  end

  def make_request(verb, endpoint, options = {})
    options[:headers] = headers
    # TODO: improve?
    if options[:body].is_a?(Hash) || options[:body].is_a?(Array)
      options[:body] = options[:body].to_json
    end

    r = HTTParty.send verb, "#{url}#{endpoint}", options
    if r.code >= 400 && r.code < 600
      raise "There was an error (#{r.code}) - #{r}"
    end
    r
  end
end

api = MyApi.new 'https://tiy-sinatra-todo.herokuapp.com'
# api = MyApi.new "http://localhost:4567"

puts 'Welcome to the TODO manager'
puts 'What is your username? > '
# username = gets.chomp
api.login_as 'jdabbs'

# puts "Your current todo list"
# api.list_items.each do |item|
#   puts "* #{item}"
# end
#
# puts "What would you like to add?"
# title = gets.chomp
# api.add_new_item title

puts 'Done'
