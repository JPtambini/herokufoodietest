class CreateNewTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :fname 
  		t.string :lname
  		t.string :uname
  		t.string :password
  		t.string :email
  		t.string :location
  		t.datetime :date_time
  	end
  end
end

