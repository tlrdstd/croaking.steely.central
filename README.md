# What's in a name?

https://map.what3words.com/croaking.steely.central

# Setup

    gem install bundler --user-install
    git clone https://github.com/tlrdstd/croaking.steely.central
    cd croaking.steely.central
    bundle install --path=.bundle

    # with explanatory test names
    bundle exec rspec spec/ --format=doc

    # with explicit test input/output
    VERBOSE=true bundle exec rspec spec/
    bundle exec rspec spec/ --format=doc
