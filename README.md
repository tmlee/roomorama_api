# RoomoramaApi

Ruby wrapper to call Roomorama API V1.0 at https://roomorama.com/api.

For a step by step guide on getting started with Roomorama API, refer to https://roomorama.com/api/step_by_step.

## Installation

Add this line to your application's Gemfile:

    gem 'roomorama_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roomorama_api

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
	perks_list
	perks_get_data
	users_me
	users_update_profile
	users_get_data
	users_register
