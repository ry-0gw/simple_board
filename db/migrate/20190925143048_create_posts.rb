class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :topic, foreign_key: true

      t.timestamps
    end
    add_index :posts, [:topic_id, :created_at]
  end
end
