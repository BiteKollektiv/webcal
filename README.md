[![Build Status](https://travis-ci.org/BatchZero/webcal.png?branch=master)](https://travis-ci.org/BatchZero/webcal) [![Code Climate](https://codeclimate.com/github/BatchZero/webcal.png)](https://codeclimate.com/github/BatchZero/webcal)
## The Webcalendar
Anonymous Webcalendars as a service.

### Contributing

Check out the [issues](https://github.com/carolinagc/webcalendar/issues) and see if there's something you want to work on.
If you found something you want to fix, fork the repository and submit a pull request with your changes.

### Setup the project locally
**External dependencies:** GraphViz, Postgres

In order to start the server or run the tests locally, you will need to create a postgres user called tester, with the same password. We will provide a rake task that does that for you in the near future.

    git clone git@github.com:<you>/webcalendar.git
    bundle install
    rails s

Running the tests

    rake spec
    
Checking for missing translations

    rake i18n:missing

### Questions?
Just [create an issue](https://github.com/carolinagc/webcalendar/issues/new) tagged as a *question*.
