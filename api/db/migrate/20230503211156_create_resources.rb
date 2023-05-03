class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table(:resources) do |t|
      t.string(:slug, null: false)
      t.string(:name, null: false)
      t.text(:summary, null: false)

      t.timestamps
    end
  end
end
