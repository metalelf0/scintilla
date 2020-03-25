#!/bin/sh
mv app/models/scintilla/once_script.rb app/models/scintilla/scintilla_script.rb
mv app/assets/config/once_manifest.js app/assets/config/scintilla_manifest.js
mv once.gemspec scintilla.gemspec
mv test/models/scintilla/once_script_test.rb test/models/scintilla/scintilla_script_test.rb
mv test/once_test.rb test/scintilla_test.rb
mv test/fixtures/scintilla/once_scripts.yml test/fixtures/scintilla/scintilla_scripts.yml
mv lib/tasks/once_tasks.rake lib/tasks/scintilla_tasks.rake
mv lib/once.rb lib/scintilla.rb
mv lib/generators/scintilla/once_generator.rb lib/generators/scintilla/scintilla_generator.rb
mv lib/generators/scintilla/templates/empty_once_script.erb.tmp lib/generators/scintilla/templates/empty_scintilla_script.erb.tmp
mv lib/generators/scintilla/templates/empty_once_script.erb lib/generators/scintilla/templates/empty_scintilla_script.erb
mv db/migrate/20200323165014_create_once_once_scripts.rb db/migrate/20200323165014_create_scintilla_scripts.rb

