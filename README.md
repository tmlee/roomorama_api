# RoomoramaApi

Ruby wrapper to call Roomorama API V1.0 at https://roomorama.com/api.

For a step by step guide on getting started with Roomorama API, refer to https://roomorama.com/api/step_by_step.

This gem does not support OAuth calls yet.

## Installation

Add this line to your application's Gemfile:

    gem 'roomorama_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roomorama_api

## Usage

Currently this gem does not handle any oauth authentication or oauth api calls yet. All public calls are supported except user:register.

### Initialize a client
	
	client = RoomoramaApi::Client.new

### Get all destinations

	client.destinations_all

### Search for properties/rooms

	client.properties_find destination: 'singapore'
	client.properties_find destination: 'singapore', order: 'title_asc'

### Get data for a give property/room

	client.properties_get_data 500, strip_html: 'false'

### Supported API Calls

	destinations_all
	properties_find
	properties_get_data
	properties_find_similar
	properties_availabilities
	perks_list
	perks_get_data
	users_get_data

