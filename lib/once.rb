# frozen_string_literal: true

require 'once/engine'
Dir[Once::Engine.root + 'app/models/**/*.rb'].collect { |f| require f }

require 'once/runner'
require 'once/runnable'

module Once
  # Your code goes here...
end
