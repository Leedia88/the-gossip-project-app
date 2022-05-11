class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      # t.integer :commentable_id
      # t.string :commentable_type
      t.references :commentable, polymorphic: true

      t.references :user, index: true
      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]

  end
end
