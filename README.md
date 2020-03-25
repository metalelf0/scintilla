# Scintilla

`TL;DR`: Scintilla allows running one-time scripts in your Rails application, mimicking
the behaviour of Rails migrations.

It relies on an ActiveRecord model (`ScintillaScript`) to keep track of already ran
scripts (consider it the equivalent of the `schema_migrations` table).

It offers a rake task, `scintilla:run`, to run scripts. Integrating it with your
deployment flow is up to you.

## Typical use case

- I realize I need to do some operations involving production data, and I want to keep
  track of them;
- I create a `Scintilla` script with `rails g:scintilla [my_script_name]`, and put my
  ruby code in the `do_the_stuff` method;
- I commit and push the code to staging env; an hook in my deployment flow runs
  `rake scintilla:run`, that finds the new script and runs it;
- I check it did what intended and push the code to production.

## Advantages over other approaches

- if you're currently using `seeds.rb` for every data operation, `Scintilla` will allow
  to have a better history of scripts you have ran; also scripts no longer need to be
  idempotent - they are ran only once;
- if you're using migrations, `Scintilla` will allow to better separate concerns - you
  will be able to use migrations for db related operations and `Scintilla` for everything
  else. Also, you can safely use rails models in `Scintilla`: each script is `require`d
  conditionally, so if it has already been ran, it won't be required anymore.

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

## Questions and answers

- Q: if the script fails can I rewrite it and rerun it?
- A: if the script fails raising an exception it will be rerun on the following invocation
  of `rake scintilla:run`, cause the corresponding entry in the `scintilla_scintilla_scripts`
  table won't be created. You can spot failures either checking your deployment logs
  (scintilla logs to stdout) or by looking inside the `scintilla_scintilla_scripts` table.
  This table contains the names of scripts that have been ran, so if you run `scintilla: run`
  and your script doesn't pop up there, something might have gone wrong.

## Contributing

Feel free to open issues and PRs, fork the project as you want ;)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
