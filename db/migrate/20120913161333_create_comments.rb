class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author, :default => "Anonymous"
      t.string :message
      t.integer :post_id
      t.timestamps
    end
  end
end
