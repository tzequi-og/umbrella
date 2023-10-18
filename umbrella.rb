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

raw_response_maps = HTTP.get(gmaps_url)
parsed_response = JSON.parse(raw_response_maps)

# Extracting the latitude and longitude info from API response
results_array = parsed_response.fetch("results")
geometry_hash = results_array.at(0).fetch("geometry")
location_hash = geometry_hash.fetch("location")
lat = location_hash.fetch("lat")
long = location_hash.fetch("lng")

#Getting weather info from Pirate Weather API
pirate_weather_api_key = ENV["PIRATE_WEATHER_API_KEY"]
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + lat.to_s + "," + long.to_s

raw_response_weather = HTTP.get(pirate_weather_url)
parsed_response = JSON.parse(raw_response_weather)

# Extracting the precipitation volume from API response
currently_hash = parsed_response.fetch("currently")

current_rain = currently_hash.fetch("precipType")

if current_rain == "rain"
  puts "Take your umbrella!"
else
  puts "You're fine without an umbrella!"
end
