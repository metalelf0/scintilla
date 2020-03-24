# frozen_string_literal: true

module Once
  class Runner
    def run
      if OnceScript.exists?(filename: file_name)
        puts "#{file_name} already ran, skipping..."
      else
        puts "Running #{file_name}..."
        do_the_stuff
        OnceScript.create(filename: file_name, ran_at: Time.zone.now)
      end
    end

    def self.scripts(conditional_require = false)
      scripts = require_scripts(conditional_require)
      scripts.sort.inject([]) do |scripts_to_run, filename|
        klass = script_name(filename, true).camelize.constantize
        scripts_to_run << klass.new
      end
    end

    def do_the_stuff
      raise 'Implement this in every Once::Runner subclass...'
    end

    private

    def self.require_scripts(conditional_require)
      scripts = Dir[Rails.root.join('db', 'once', '*.rb')]
      if conditional_require
        scripts.reject! { |f| OnceScript.exists?(filename: script_name(f, false)) }
      end
      scripts.each { |f| require f }
    end

    attr_reader :file_name

    def self.script_name(full_file_path, without_extension = false)
      name = File.basename(full_file_path).gsub(/^\d+_/, '') # remove timestamp
      name = name.gsub(/\.rb$/, '') if without_extension
      name
    end
  end
end
