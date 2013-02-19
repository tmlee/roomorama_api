require_relative 'minitest_helper'
require_relative '../lib/roomorama_api'

class RoomoramaApiTest < MiniTest::Unit::TestCase

	OAUTH_TOKEN = '' # Insert OAuth token to test

	def setup
		@client = RoomoramaApi::Client.new(OAUTH_TOKEN)
	end

	def test_destinations_all

	end

	def test_search_for_properties_of_a_given_destination
		result = @client.properties_find destination: 'singapore'
		assert_kind_of Array, result["result"]
	end

	def test_get_data_for_a_property
		result = @client.properties_get_data 3002
		assert_equal result["result"]["id"], 3002
	end

	def test_get_data_for_an_empty_property
		result = @client.properties_get_data 500
		assert_equal result, {}
	end

	def test_get_information_about_me_oauth
		result = @client.users_me
		# assert_equal
	end

	def test_properties_find_similar
	end

	def test_properties_availabilities
	end

	#### Perks

	def test_perks_list
	end

	def test_perks_get_data
	end

	#### Users

	def test_users_get_data
	end



end