class CreateOnceOnceScripts < ActiveRecord::Migration[6.0]
  def change
    create_table :once_once_scripts do |t|
      t.string :filename
      t.datetime :ran_at

      t.timestamps
    end
  end
end
