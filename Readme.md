# Foursquare Mapped

## Installation

#### Development
	# create foursquare developer account at https://developer.foursquare.com/
	# setup config/initializers/00_secret_keys.rb with foursquare keys
	# setup /config/database.yml
	rake db:create
	rake db:schema:load
    rails s
    visit at http://localhost:3000/

#### Test
    rspec # run all tests


