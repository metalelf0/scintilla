require 'test_helper'

module Scintilla
  class RunnerTest < ActiveSupport::TestCase
    test "#scripts: returns no scripts when dir is empty" do
      remove_all_scripts
      scripts = klass.scripts
      assert_empty scripts
    end

    test "#scripts: returns scripts when dir is not empty" do
      create_dummy_script
      scripts = klass.scripts
      assert_not_empty scripts
    end

    private

    def klass = Scintilla::Runner

    def create_dummy_script
      FileUtils.cp(
        "#{File.dirname(__FILE__)}/../fixtures/files/hallo.rb",
        "#{File.dirname(__FILE__)}/../dummy/db/scintilla/")
    end

    def remove_all_scripts
      Dir.glob("#{File.dirname(__FILE__)}/../dummy/db/scintilla/*").each do |file|
        FileUtils.rm(file)
      end
    end
  end
end
