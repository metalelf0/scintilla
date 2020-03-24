require 'rails/generators'
require "fileutils"

class OnceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_once_file
    dir = Rails.root.join "db", "once"
    FileUtils.mkdir_p dir
    file = Rails.root.join "db", "once", "#{Time.zone.now.strftime('%Y%m%d')}_#{name.gsub(/\.rb$/, '').underscore}.rb"
    copy_file "empty_once_script.erb", file

    gsub_file file, "KlassName", name.camelize
  end
end
