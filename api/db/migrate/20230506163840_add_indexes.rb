class AddIndexes < ActiveRecord::Migration[6.1]
  def change
    add_index :resources, :created_at, order: { created_at: :asc }
    add_index :resources, :slug
  end
end
