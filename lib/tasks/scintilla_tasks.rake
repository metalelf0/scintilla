# frozen_string_literal: true

namespace :scintilla do
  desc 'Run Scintilla scripts'
  task run: :environment do
    Scintilla::Runner.run
  end
end
