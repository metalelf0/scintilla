# frozen_string_literal: true

require 'scintilla/engine'
Dir[Scintilla::Engine.root + 'app/models/**/*.rb'].collect { |f| require f }

require 'scintilla/runner'
require 'scintilla/runnable'

module Scintilla
  # Your code goes here...
end
