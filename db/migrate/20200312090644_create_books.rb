class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :user, foreign_key: true
      t.string :explain
      t.string :change
      t.string :image

      t.timestamps
    end
  end
end
