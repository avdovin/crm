class CreateCrmTasks < ActiveRecord::Migration
  def change
    create_table :crm_tasks do |t|
      t.string :name
      t.integer :priority
      t.integer :domain_id
      t.datetime :start_date
      t.datetime :end_date
      t.integer :id_handler
      t.integer :tasktype
      t.integer :branch_id
      t.integer :tasktime
      t.integer :elapsed_time
      t.boolean :is_allday
      t.boolean :is_notify
      t.text :comment

      t.timestamps
    end
  end
end
