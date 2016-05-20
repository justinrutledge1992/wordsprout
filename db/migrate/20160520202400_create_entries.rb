class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :title
      t.text :content
      t.references :user, index: true
      t.references :parent_entry, index: true

      t.timestamps null: false
    end
  end
end
