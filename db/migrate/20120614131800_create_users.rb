class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :facebook_access_token
      t.string :facebook_id
      t.string :email
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
