require 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params)
  uri = URI.parse(url)

  # Create the HTTP POST request
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")

  request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
  request.body = body_params.to_json

  # Send the request and get the response
  response = http.request(request)

  # Print response status and body
  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  puts JSON.generate(JSON.parse(response.body))
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
