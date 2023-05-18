# README

# My Project

This is a Ruby on Rails project that allows users to manage pages and their associated links.

## Tools Used

The following tools and technologies were used in the development of this project:

- Ruby on Rails: a web application framework written in Ruby.
- Nokogiri: a gem used for HTML parsing and scraping.
- Devise: a gem for user authentication in Rails.
- WillPaginate: a gem for pagination of ActiveRecord results.
- RSpec: a testing framework for Ruby.

## Prerequisites

Make sure you have the following installed on your system:

- Ruby (version 3.2.2)
- RubyGems
- Bundler

## Getting Started

To get started with the project, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/salgc8262/koombea_web_scrapper.git

   ```

2. Change into the project directory:
   cd my-project

3. Install dependencies using Bundler:
   bundle install

4. Set up the database:
   rails db:migrate

5. Start the Rails server:
   rails server
   The application will now be accessible at http://localhost:3000

## Running Tests

This project uses RSpec for testing. To run the tests, follow these steps:

1. Ensure you have the necessary development and test dependencies installed:
   bundle install --with development test

2. Run the RSpec command to execute the tests:
   rspec

RSpec will run all the tests in the spec directory and provide you with the test results.
