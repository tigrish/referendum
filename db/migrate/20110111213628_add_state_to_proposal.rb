class AddStateToProposal < ActiveRecord::Migration
  def self.up
    add_column :proposals, :state, :string
  end

  def self.down
    remove_column :proposals, :state
  end
end