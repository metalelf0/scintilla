# frozen_string_literal: true

module Scintilla
  class Runnable
    attr_accessor :file_name

    # Runs the script, unless already ran.
    #
    # @return [<Scintilla::ScintillaScript>] the created ScintillaScript on DB, only if
    #         script has ran successfully.
    #
    def run
      if ScintillaScript.exists?(filename: file_name)
        puts "#{file_name} already ran, skipping..."
      else
        puts "Running #{file_name}..."
        do_the_stuff
        ScintillaScript.create(filename: file_name, ran_at: Time.zone.now)
      end
    end

    def do_the_stuff
      raise 'Implement this in every Scintilla::Runner subclass...'
    end
  end
end
