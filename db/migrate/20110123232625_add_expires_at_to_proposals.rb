class AddExpiresAtToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :expires_at, :datetime
    Proposal.update_all(:expires_at => Time.now)
  end

  def self.down
    remove_column :proposals, :expires_at
  end
end