# DLME Production Integration Tests
![example workflow](https://github.com/waynegraham/dlme_tests/actions/workflows/ruby.yml/badge.svg)


# Installation

```
bundle install
```

You'll also need ChromeDriver and the `brew` version doesn't keep pace with Chrome's evergreen releases.

* Get the latest [ChromeDriver](https://sites.google.com/chromium.org/driver/downloads)
* Extract and move chromedriver to `/usr/local/bin/`
* Open the file (`open /usr/local/bin/`) and right-click open `chromedriver` (for the **Error: "chromedriver" cannot be opened because the developer cannot be verified** message in macOS)

## Running Tests Locally

```
be rspec spec/production_site_spec.rb
be rspec spec/browse_categories_spec.rb
be rspec spec/*_spec.rb
```

## Manual Run

You can run these tests server side by

* Go to the [Github Actions](https://github.com/waynegraham/dlme_tests/actions) page
* Click on [Manual workflow](https://github.com/waynegraham/dlme_tests/actions/workflows/manual.yml)
* Click on Run worflow

Once the workflow is queued, you can click on the matrix to follow the progress.

If there are any errors, collaborators on the project will be notified and the badge on the project will be red.

## Automatic Run

These tests run every Tuesday at midnight. If there is a failure, repo collaborators will be notified and the badge on the page will be red.

## Time measurements

```
rake performance:all report
```

TODO: link to the metadata record