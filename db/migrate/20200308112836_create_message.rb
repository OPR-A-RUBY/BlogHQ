class CreateMessage < ActiveRecord::Migration[6.0]
  def change
  	create_table :Messages do |t|
  		t.text :context
  		t.text :autor
  		t.text :post_id
  		t.timestamps
  	end	
  end
end
