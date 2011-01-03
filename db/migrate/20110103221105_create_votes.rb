class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :proposal_id
      t.integer :user_id
      t.integer :value, :size => 1, :nil => false
      t.timestamps
    end
    add_index :votes, :proposal_id
    add_index :votes, :user_id
  end

  def self.down
    drop_table :votes
  end
end