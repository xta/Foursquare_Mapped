# Foursquare Mapped

Rails 8 + PostgreSQL sample app for getting all your Foursquare check ins.

Requires Ruby 3.4.7 (see `.ruby-version`) and PostgreSQL.

***Warning: this app is not secure and NOT for production usage. Use at your own risk.***

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

    bin/rails db:create db:schema:load
    bin/rails db:schema:load RAILS_ENV=test

#### Usage Locally
    bin/rails s
    open http://localhost:3000/

#### Run all tests
    bundle exec rspec

## Dependencies note

Two upstream gems this app originally used were abandoned in 2014 and cannot be
installed alongside a current Rails, so their (small) functionality now lives in
this repo:

* `omniauth-foursquare` -> `lib/omniauth/strategies/foursquare.rb`
* `foursquare2` -> `lib/foursquare_wrapper/foursquare_wrapper.rb` (calls the
  Foursquare v2 REST API over faraday)

Behaviour is unchanged; only the plumbing was replaced.

## License

Foursquare Mapped is released under the [MIT License](http://opensource.org/licenses/MIT).
