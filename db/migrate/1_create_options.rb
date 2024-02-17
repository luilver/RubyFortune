class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.string :text
      t.boolean :is_correct, default: false
      t.references :poll
    end
  end
end
