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

  def test_properties_price_check
    stub_get("https://api.roomorama.com/v1.0/inquiries/new.json?room_id=60425&check_in=2013-07-01&check_out=2013-07-10", 'properties/price_check.json')
    result = @client.properties_price_check 60425, check_in:"2013-07-01", check_out:"2013-07-10"
    assert_equal result["result"]["total"], 9168
    assert_equal result["result"]["check_in"], "2013-07-01"
    assert_equal result["result"]["check_out"], "2013-07-10"
  end

  def test_properties_reviews
    stub_get("https://api.roomorama.com/v1.0/rooms/8582/reviews", 'properties/reviews.json')
    result = @client.properties_reviews 8582
    assert_equal result["result"].first["rating"], 1
    assert_equal result["result"].first["room"]["id"], 8582
  end

  #### Favorites

  def test_favorites_list
    stub_get("https://api.roomorama.com/v1.0/favorites", 'favorites/list.json')
    result = @client.favorites_list
    assert_equal result["result"].first["title"], "[7801] STUNNING WEST VILLAGE"
  end

  def test_favorites_create
    stub_post("https://api.roomorama.com/v1.0/favorites", "favorites/create.json")
    result = @client.favorites_create room_id: 2291
    assert_equal result["room_id"], 2291
  end

  #### Perks

  def test_perks_list
    stub_get("https://api.roomorama.com/v1.0/perks?destination=singapore", "perks/list.json")
    result = @client.perks_list destination: "singapore"
    assert_equal result["count"], 25
  end

  def test_perks_get_data
    stub_get("https://api.roomorama.com/v1.0/perks/25", "perks/get_data.json")
    result = @client.perks_get_data 25
    assert_equal result["result"]["name"], "Mygola Trip Planning"
  end

  #### Users

  def test_users_me
    stub_get("https://api.roomorama.com/v1.0/me", "users/me.json")
    result = @client.users_me
    assert_equal result["result"]["id"], 1419
  end

  def test_users_update_profile
    stub_put("https://api.roomorama.com/v1.0/me", "users/update_profile.json")
    result = @client.users_update_profile
    assert_equal result["result"]["id"], 1419
  end

  def test_users_get_data
    stub_get("https://api.roomorama.com/v1.0/users/1900", "users/get_data.json")
    result = @client.users_get_data 1900
    assert_equal result["result"]["id"], 1900
  end

  def test_users_register
    stub_post("https://api.roomorama.com/v1.0/users", "users/register.json")
    result = @client.users_register login: "test123", password: "testapi", email: "test@example.com", first_name: "Skrillex", last_name: "Avicii"
    assert_equal result["result"]["login"], "test123"
  end

  def test_users_reviews
    stub_get("https://api.roomorama.com/v1.0/users/291/reviews", "users/reviews.json")
    result = @client.users_reviews 291
    assert_equal result["result"][0]["host_to_guest"], false
    assert_equal result["result"][0]["host"]["id"], 291
  end

  #### Hosts/Properties

  def test_hosts_properties_list
    stub_get("https://api.roomorama.com/v1.0/host/rooms", "hosts/properties/list.json")
    result = @client.host_properties_list
    assert_equal result["result"][0]["id"], 9999
  end

  def test_hosts_properties_show
    stub_get("https://api.roomorama.com/v1.0/host/rooms/9999", "hosts/properties/show.json")
    result = @client.host_properties_show 9999
    assert_equal result["result"]["id"], 9999
  end

  def test_hosts_properties_create
    stub_post("https://api.roomorama.com/v1.0/host/rooms/9999", "hosts/properties/create.json")
    result = @client.host_properties_create 9999
    assert_equal result["result"]["id"], 9999
  end

  def test_hosts_properties_delete
    stub_put("https://api.roomorama.com/v1.0/host/rooms/9999", "hosts/properties/update.json")
    result = @client.host_properties_update 9999
    assert_equal result["result"]["id"], 9999
  end

  #### Hosts/Availabilities

  def test_hosts_availabilities_list
    stub_get("https://api.roomorama.com/v1.0/host/rooms/9999/availabilities.json", "hosts/availabilities/list.json")
    result = @client.host_availabilities_list 9999
    assert_equal result["count"], 1
  end

  def test_hosts_availabilities_update
    stub_put("https://api.roomorama.com/v1.0/host/rooms/9999/availabilities.json", "hosts/availabilities/update.json")
    result = @client.host_availabilities_update 9999
    assert_equal result[0].is_a?(Hash), true
  end

  #### Host/Inquiries

  def test_hosts_inquiries_list
    stub_get("https://api.roomorama.com/v1.0/host/inquiries.json", "hosts/inquiries/list.json")
    result = @client.host_inquiries_list
    assert_equal result["count"], 2
  end

  def test_hosts_inquiries_show
    stub_get("https://api.roomorama.com/v1.0/host/inquiries/9999.json", "hosts/inquiries/show.json")
    result = @client.host_inquiries_show 9999
    assert_equal result["result"]["id"], 9999
  end

  # def test_get_data_for_an_empty_property
  #   assert_raises RoomoramaApi::NotFound do
  #     result = @client.properties_get_data 500
  #   end
  # end

  # def test_get_information_about_me_oauth
  #   result = @client.users_me
  #   # assert_equal
  # end

  #### Favorites

  # def test_favorites_create
  #   result = @client.favorites_create room_id: 1890
  # end

  # def test_favorites_list
  #   result = @client.favorites_list
  #   puts result
  # end

  # def test_favorites_delete
  #   result = @client.favorites_delete 1890
  #   puts result
  #end

  #### Perks


  #### Users


end