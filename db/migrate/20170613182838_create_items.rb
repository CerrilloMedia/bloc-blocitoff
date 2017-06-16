class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :body
      t.references :user, index: true, foreign_key: true
      t.references :list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
