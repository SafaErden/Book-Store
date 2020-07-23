class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :icon
      t.integer :author_id
      t.timestamps
    end
  end
end
