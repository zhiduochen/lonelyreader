class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :board_id
      t.integer :user_id

      t.timestamps
    end
  end
end
