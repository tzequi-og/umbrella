require "http"
require "json"

#Introduction to the program + getting info from User's location
puts "==================================="
puts "Will you need an Umbrella today?"
puts "==================================="
puts ""
puts "Where are you?"

location = gets

# Getting API info from Google Maps
gmaps_api_key = ENV["GMAPS_KEY"]
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location.gsub(" ","%20").gsub("\n","") + "&key=" + gmaps_api_key

raw_response = HTTP.get(gmaps_url)
parsed_response = JSON.parse(raw_response)

# Extracting the latitude and longitude info from API response
results = parsed_response.fetch("results")
geometry = results.at(0).fetch("geometry")
location = geometry.fetch("location")
lat = location.fetch("lat")
long = location.fetch("lng")

#Getting weather info from Pirate Weather API

