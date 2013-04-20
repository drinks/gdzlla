# GDZLLA

Source for the twitter (currently tweetbot only)-to-flickr API bridge
at <https://gdzl.la>

---

Built for Rails 3 and Heroku.

Running it yourself:

1. Fork/clone the repo
2. Create heroku app
3. Bundle install
4. Set up necessary addons
    - `heroku addons:add mongolab`
    - `heroku addons:add redistogo`
    - `heroku addons:add newrelic`
    - `heroku addons:remove heroku-postgresql`
    - `heroku plugins:install git://github.com/ddollar/heroku-config.git`
5. Fill out & push .env
    - `cp .env.example .env`
    - `heroku config:push`
6. Deploy to heroku
    - `git push heroku master`
