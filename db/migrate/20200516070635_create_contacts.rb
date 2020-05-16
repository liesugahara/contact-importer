class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.datetime :dob
      t.string :phone
      t.string :address
      t.string :credit_card
      t.string :franchise
      t.string :email
      t.timestamps
    end
  end
end
