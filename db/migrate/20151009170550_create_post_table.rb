class CreatePostTable < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.string :name
  		t.string :subject
  		t.text :body
  		t.datetime :date_time
  		t.integer :user_id
  	end
  end
end
