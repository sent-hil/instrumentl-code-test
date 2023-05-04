class CreateResourceFaqs < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_faqs do |t|
      t.integer :priority, default: 0, null: false
      t.text :question, null: false
      t.text :answer, null: false
      t.references :resource, null: false, foreign_key: true

      t.timestamps
    end
  end
end
