# Youtrack report builder

## Project description

Build weekly reports from csv source file

## Dependencies

* Ruby 2.4.2
* Rails 5

Setup required dependencies from `Brewfile`:
```bash
brew tap Homebrew/bundle
brew bundle
```

## Quick Start

```bash
# clone repo
git clone git@github.com:ruslankhaertdinov/youtrack_reporter.git
cd youtrack_reporter

# run setup script
bin/setup

# configure ENV variables in .env
vim .env

# run server on 5000 port
bin/server
```

## Scripts

* `bin/setup` - setup required gems and migrate db if needed
* `bin/quality` - run brakeman and rails_best_practices for the app
* `bin/ci` - should be used in the CI to run specs

## Staging

* http://youtrack-reporter.herokuapp.com

## Production

* http://youtrack-reporter.herokuapp.com
