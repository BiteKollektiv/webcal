## Want to contribute?
Thank you, that's awesome! This guide should help you to get started.


Check out the [issues](https://github.com/BatchZero/webcal/issues) and see if there's something you want to work on. We have have a [beginner-friendly](https://github.com/BatchZero/webcal/issues?labels=beginner-friendly&page=1&state=open) tag for things that we believe are simple enough to get started.

If you found something you want to fix, fork the repository and submit a pull request with your changes.
Whenever you want to contribute something, make sure to add tests as well.

### Setting up the project
Since everyone of us is using Linux, we only have instructions for (Ubuntu) Linux right now. If you are a Mac user and want to help out, feel free to add instructions for Mac to this file or to the wiki.

#### Install dependencies

    sudo apt-get install postgresql postgresql-contrib graphviz

#### Clone & bundle

    git clone git@github.com:BatchZero/webcal.git && cd webcal
    bundle install

#### Create a postgres user

    sudo -u postgres createuser --superuser tester
    sudo -u postgres psql
    postgres=# \password tester
    Enter new password: tester
    Enter it again: tester
    \q

In this example we created a postgres user called tester, with the same password. Feel free to choose anything you want.

#### Setting up the .env files

First, you will need to generate a secret token with `rake secret`.

Next, make a copy of the provided .env files:

    cp .env.test{.example,}
    cp .env.development{.example,}

Now open the .env files and replace the example values with the actual values. Here's an example for `.env.test` with the user from above:

    SECRET_TOKEN=229e0685eb7d82503ba9e4db71de77118e28e0bc6e407511fc74883cae9f239....
    DB_NAME=webcal_test
    DB_USER=tester
    DB_PASSWORD=tester


Now you should be able to start the server (`rails s`) and run the test suite (`rake spec`).
