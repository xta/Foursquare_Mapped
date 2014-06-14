# Foursquare Mapped

Rails 4.1 + PostgreSQL sample app for getting all your Foursquare check ins. Note: this app is only intended for local usage & NOT production env.

## Setup Locally

    git clone git@github.com:xta/Foursquare_Mapped.git
    cd Foursquare_Mapped/
    bundle

    # create foursquare developer account at https://developer.foursquare.com/

    cp config/secrets.yml.example config/secrets.yml
    # update config/secrets.yml file with your foursquare keys

    rake db:create db:schema:load
    rake db:schema:load RAILS_ENV=test

#### Usage Locally
    rails s
    open http://localhost:3000/

#### Run all tests
    rspec
