class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email, index: true
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
