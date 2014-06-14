# Foursquare Mapped

Rails 4.1 + PostgreSQL sample app for getting all your Foursquare check ins. Note: this app is only intended for local usage & NOT production env.

## Setup Locally

    git clone git@github.com:xta/Foursquare_Mapped.git
    cd Foursquare_Mapped/
    bundle

    # create foursquare developer account at https://developer.foursquare.com/
    
    # create a new foursquare app at https://foursquare.com/developers/register
![App Registration Page](/../master/public/dev_4sq_register_app.png?raw=true)

`Your app name` can be anything.

`Download / welcome page url` is `http://localhost:3000`

`Your privacy policy url` is `http://localhost:3000/privacy`

`Redirect URI(s)` is `http://localhost:3000/users/auth/foursquare/callback`

Click `Save Changes`

You will be presented with your new app's page. Make note of `Client id` and `Client secret`.

    cp config/secrets.yml.example config/secrets.yml
    # update config/secrets.yml file with your foursquare keys (Client id and Client secret)

    rake db:create db:schema:load
    rake db:schema:load RAILS_ENV=test

#### Usage Locally
    rails s
    open http://localhost:3000/

#### Run all tests
    rspec
