class CreateCrmUsers < ActiveRecord::Migration
  def change
    create_table :crm_users do |t|
      t.string :nickname
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
