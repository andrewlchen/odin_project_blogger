class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :comment
      t.references :article, index: true

      t.timestamps
    end
  end
end
