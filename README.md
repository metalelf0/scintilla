# Scintilla

`TL;DR`: Scintilla allows running one-time scripts in your Rails application, mimicking
the behaviour of Rails migrations.

It relies on an ActiveRecord model (`ScintillaScript`) to keep track of already ran
scripts (consider it the equivalent of the `schema_migrations` table).

It offers a rake task, `scintilla:run`, to run scripts. Integrating it with your
deployment flow is up to you.

## Usage

### Generating a new Scintilla script

`> rails g scintilla do_something_useful`

This will create a timestamped file under `db/scintilla`, like
`20200324_do_something_useful.rb`. You will need to edit this file and fill the
`do_the_stuff` method with the code you want to run.

### Running Scintilla scripts

`> rails scintilla:run`

This will, in turn:

- check the script files under `db/scintilla`;
- for each of them, check if it has already been ran (a `Scintilla::Script` record is
  present on DB), and only require the ones that still need to be ran;
- run the missing scintilla scripts, and create `Scintilla::Script` records on DB for each
  of them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scintilla'
```

And then execute:

```bash
$ rails scintilla:install:migrations
$ rails db:migrate
```

## Contributing

Feel free to open issues and PRs, fork the project as you want ;)


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
