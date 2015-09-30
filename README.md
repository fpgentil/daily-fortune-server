Daily Fortune Server
===================

## What is it?
Simple application that generates a random `fortune` (see more at: https://en.wikipedia.org/wiki/Fortune_(Unix)) and emails the user daily.

## Purpose
* Study Docker
* Create a Sinatra/Sidekiq skeleton
* Deploy with AWS

## Routes
```ruby
GET fortunes/random
GET fortunes/database?q=<computer|art|..>
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/daily-fortune-server/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request