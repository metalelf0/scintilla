# Once

`TL;DR`: Once allows running one-time scripts in your Rails application, mimicking
the behaviour of Rails migrations.

It relies on an ActiveRecord model (`Once::Script`) to keep track of already ran
scripts (consider it the equivalent of the `schema_migrations` table).

It offers a rake task, `once:run`, to run scripts. Integrating it with your
deployment flow is up to you.

## Usage

### Generating a new Once script

`> rails g once do_something_useful`

This will create a timestamped file under `db/once`, like
`20200324_do_something_useful.rb`. You will need to edit this file and fill the
`do_the_stuff` method with the code you want to run.

### Running Once scripts

`> rails once:run`

This will, in turn:

- check the script files under `db/once`;
- for each of them, check if it has already been ran (a `Once::Script` record is
  present on DB), and only require the ones that still need to be ran;
- run the missing once scripts, and create `Once::Script` records on DB for each
  of them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'once'
```

And then execute:

```bash
$ rails once:install:migrations
$ rails db:migrations
```

## Contributing

Feel free to open issues and PRs, fork the project as you want, I'll try to giver


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
