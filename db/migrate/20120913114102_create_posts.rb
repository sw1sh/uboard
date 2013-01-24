class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :default => "No Title"
      t.string :author, :default => "Anonymous"
      t.string :content

      t.timestamps
    end
  end
end
