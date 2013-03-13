require 'minitest_helper'
require 'roomorama_api'

class RoomoramaApiTest < MiniTest::Unit::TestCase

	OAUTH_TOKEN = 'xxx' # Insert OAuth token to test

	def setup
		@client = RoomoramaApi::Client.new(OAUTH_TOKEN)
	end

	def test_order
		:alpha
	end

	#### Destinations

	def test_destinations_all
		stub_get("https://api.roomorama.com/v1.0/destinations", 'destinations/all.json')
		result = @client.destinations_all
		assert_equal result["result"].count, 5288
	end

	#### Properties

	def test_properties_find
		stub_get("https://api.roomorama.com/v1.0/rooms?destination=singapore&num_guests=2&num_rooms=2&max_price=300&min_price=100", 'properties/find.json')
		result = @client.properties_find(destination:"singapore", num_guests:2, num_rooms:2, max_price:300, min_price:100)
		assert_equal result["result"].count, 10
	end

	def test_properties_get_data
		stub_get("https://api.roomorama.com/v1.0/rooms/3002", 'properties/get_data.json')
		result = @client.properties_get_data 3002
		assert_equal result["result"]["id"], 3002
	end

	def test_properties_find_similar
		stub_get("https://api.roomorama.com/v1.0/rooms/3002/similar", 'properties/find_similar.json')
		result = @client.properties_find_similar 3002
		assert_equal result["result"].count, 5
		assert_equal result["result"].first["title"], "Madison Avenue Apartment for rent on weekends"
	end

	def test_properties_availabilities
		stub_get("https://api.roomorama.com/v1.0/rooms/3002/availabilities?start_date=2013-12-01&end_date=2013-12-31", 'properties/availabilities.json')
		result = @client.properties_availabilities 3002, start_date:"2013-12-01", end_date:"2013-12-31"
		assert_equal result["result"].count, 31
		assert_equal result["result"].first["available"], true
	end

	# def test_get_data_for_an_empty_property
	# 	assert_raises RoomoramaApi::NotFound do
	# 		result = @client.properties_get_data 500
	# 	end
	# end

	# def test_get_information_about_me_oauth
	# 	result = @client.users_me
	# 	# assert_equal
	# end

	#### Favorites

	# def test_favorites_create
	# 	result = @client.favorites_create room_id: 1890
	# end

	# def test_favorites_list
	# 	result = @client.favorites_list
	# 	puts result
	# end

	# def test_favorites_delete
	# 	result = @client.favorites_delete 1890
	# 	puts result
	#end

	#### Perks


	#### Users


end