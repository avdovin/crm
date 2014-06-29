class CreateCrmAccesses < ActiveRecord::Migration
  def change
    create_table :crm_accesses do |t|
		t.text 		:text
		t.text 		:comment

      t.timestamps
    end
  end
end
