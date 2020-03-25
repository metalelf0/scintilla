# frozen_string_literal: true

require 'rails/generators'
require 'fileutils'

class ScintillaGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_scintilla_file
    dir = Rails.root.join 'db', 'scintilla'
    FileUtils.mkdir_p dir
    file = Rails.root.join 'db', 'scintilla', "#{Time.zone.now.strftime('%Y%m%d')}_#{name.gsub(/\.rb$/, '').underscore}.rb"
    copy_file 'empty_scintilla_script.erb', file

    gsub_file file, 'KlassName', name.camelize
  end
end
