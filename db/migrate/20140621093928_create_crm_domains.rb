class CreateCrmDomains < ActiveRecord::Migration
  def change
    create_table :crm_domains do |t|
			t.string  	:name, presence: true, uniqueness: true
			t.date    	:paiddate, :default => '0000-00-00'
			t.date    	:regdate, :default => '0000-00-00'
			t.integer 	:access_id
			t.text	 	  :comment

    	t.timestamps
    end
  end
end
