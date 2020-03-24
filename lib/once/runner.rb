# frozen_string_literal: true

module Once
  class Runner
    def self.run
      scripts.each(&:run)
    end

    # Get the list of scripts to be ran.
    #
    # @param [<Boolean>] conditional_require whether to only require
    #        scripts that still haven't ran. Defaults to true.
    #
    # @return [<Array<Once::Runnable>>] the list of Runnable objects
    #         to be ran.
    #
    def self.scripts(conditional_require = true)
      scripts = require_scripts(conditional_require)
      scripts.sort.inject([]) do |scripts_to_run, filename|
        klass = script_name(filename, true).camelize.constantize
        scripts_to_run << klass.new
      end
    end

    # Requires the scripts in the db/once path, to allow loading
    # them for execution.
    #
    # @param [<Boolean>] conditional_require whether to only require
    #        scripts that still haven't ran. This is useful if
    #        older scripts contain references to no longer present
    #        classes, and to boost performances. Set it to false
    #        for debugging purposes.
    #
    def self.require_scripts(conditional_require)
      scripts = Dir[Rails.root.join('db', 'once', '*.rb')]
      if conditional_require
        scripts.reject! { |f| OnceScript.exists?(filename: script_name(f, false)) }
      end
      scripts.each { |f| require f }
    end
    private_class_method :require_scripts

    # Extract script_name from file_name, removing timestamp and optionally
    # removing extension.
    #
    # @param [<String>] full_file_path the full file path, e.g. /a/b/c.rb
    # @param [<Boolean>] without_extension remove extension from file name.
    #                    Defaults to false
    #
    # @return [<String>] the script name, e.g. c.rb
    #
    def self.script_name(full_file_path, without_extension = false)
      name = File.basename(full_file_path).gsub(/^\d+_/, '') # remove timestamp
      name = name.gsub(/\.rb$/, '') if without_extension
      name
    end
  end
end
