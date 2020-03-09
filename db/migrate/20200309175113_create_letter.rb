class CreateLetter < ActiveRecord::Migration[6.0]
  def change
  	create_table :Letters do |l|
  		l.text :content
  		l.text :autor
  		l.text :email
  		l.text :old
  		l.text :ansver
  		l.timestamps
  	end	
  end
end
