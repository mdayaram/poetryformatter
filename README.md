Poetry Formatter
================

Attempts to format poetry into html friendly format.

### Ruby

To install Ruby, I prefer using RVM:

https://rvm.io/rvm/install


### Setup

After you have Ruby installed using RVM, create a gemset for this project and
install the corresponding gems using bundler.

```bash
$ rvm gemset --create use poetryformatter
$ bundle install
```

### Running

This is standalone Sinatra app, so you can just run it by running the app.rb
file:

```bash
$ bundle exec ruby app.rb
```

Go to http://localhost:4567/ to view your locally running copy.
