class AddClosedAtToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :closed_at, :datetime
  end

  def self.down
    remove_column :proposals, :closed_at
  end
end