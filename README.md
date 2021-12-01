# DLME Production Integration Tests
![example workflow](https://github.com/waynegraham/dlme_tests/actions/workflows/ruby.yml/badge.svg)


# Installation

```
brew install chromedriver
bundle
```

## Running Tests

```
be rspec spec/production_site_spec.rb
be rspec spec/browse_categories_spec.rb
be rspec spec/*_spec.rb
```

## Time measurements

```
rake performance:all report
```

TODO: link to the metadata record