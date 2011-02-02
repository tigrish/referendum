class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :expiry_seconds
      t.integer :participation_percentage
      t.timestamps
    end
    add_column :proposals, :category_id, :integer
  end

  def self.down
    drop_table :categories
    remove_column :proposals, :category_id
  end
end
