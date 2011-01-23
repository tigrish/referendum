class AddExpiresAtToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :expires_at, :datetime
  end

  def self.down
    remove_column :proposals, :expires_at
  end
end