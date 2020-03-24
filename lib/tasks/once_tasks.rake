# frozen_string_literal: true

namespace :once do
  desc 'Run Once scripts'
  task run: :environment do
    Once::Runner.run
  end
end
