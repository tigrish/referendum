class AddAcceptedToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :accepted, :boolean
  end

  def self.down
    remove_column :proposals, :accepted
  end
end