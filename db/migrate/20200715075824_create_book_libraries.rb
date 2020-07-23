class CreateBookLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :book_libraries do |t|
      t.belongs_to :book
      t.belongs_to :library
      t.timestamps
    end
  end
end
