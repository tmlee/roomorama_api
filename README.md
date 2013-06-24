[![Build Status](https://travis-ci.org/tmlee/roomorama_api.png)](https://travis-ci.org/tmlee/roomorama_api)

# RoomoramaApi

RoomoramaApi is a Ruby gem that wraps the Roomorama API V1.0 documented at https://roomorama.com/api.

For a step by step guide on getting started with Roomorama API, refer to https://roomorama.com/api/step_by_step.

This gem does not handle OAuth authentication or token generation. You may want to use https://github.com/intridea/omniauth and the Roomorama OAuth strategy at https://github.com/roomorama/omniauth-roomorama

## Installation

Add this line to your application's Gemfile:

    gem 'roomorama_api'

And then execute:

    $ bundle


## Usage

Currently this gem does not handle any oauth authentication yet. Host and Guest API calls are not support yet in this version.

### Initialize a client
	
	client = RoomoramaApi::Client.new

### Initialize a client with OAuth token

	client = RoomoramaApi::Client.new '<OAUTH TOKEN>'

### Get all destinations

	client.destinations_all

### Search for properties/rooms

	client.properties_find destination: 'singapore'
	client.properties_find destination: 'singapore', order: 'title_asc'

### Get data for a give property/room

	client.properties_get_data 500, strip_html: 'false'


### Make OAuth calls - get information about myself

	client.user_me

### Supported API Calls

	destinations_all
	properties_find
	properties_get_data
	properties_find_similar
	properties_availabilities
	properties_price_check
	properties_reviews
	favorites_list
	favorites_create
	favorites_delete
	perks_list
	perks_get_data
	users_me
	users_update_profile
	users_get_data
	users_register
	users_reviews
	hosts_properties_list
	hosts_properties_show

### Can't find the API Call you want?

	Submit an issue or a pull request.
	
