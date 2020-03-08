class CreatePostme < ActiveRecord::Migration[6.0]
  def change
  	create_table :Postmes do |t|
  		t.text :content
  		t.text :autor

  		t.timestamps
  	end	
  end
end
