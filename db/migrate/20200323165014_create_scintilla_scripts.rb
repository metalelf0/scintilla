# frozen_string_literal: true

class CreateScintillaScintillaScripts < ActiveRecord::Migration[6.0]
  def change
    create_table :scintilla_scintilla_scripts do |t|
      t.string :filename
      t.datetime :ran_at

      t.timestamps
    end
  end
end
