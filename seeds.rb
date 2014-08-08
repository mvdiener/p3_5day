require 'json'
require 'net/http'

def api_search(base_url)
   credentials = "?appId=#{ENV['FS_ID']}&appKey=#{ENV['FS_KEY']}"
   url = base_url + credentials
   resp = Net::HTTP.get_response(URI.parse(url))
   data = resp.body

   result = JSON.parse(data)

   if result.has_key? 'Error'
      raise "web service error"
   end
   return result
end

def seed_airlines
  results = api_search("https://api.flightstats.com/flex/airlines/rest/v1/json/active")
  results['airlines'].each do |airline|
    Airline.create(name: airline["name"], fs_code: airline["fs"])
  end
end

def seed_aiports
  results = api_search("https://api.flightstats.com/flex/airports/rest/v1/json/countryCode/US")
  results['airports'].each do |airport|
    if airport['active']
      Airport.create(name: airport['name'], fs_code: airport['fs'], city: airport['city'], state: airport['stateCode'], country: airport['countryName'])
    end
  end
end

# Seed it!
seed_aiports
seed_airlines
