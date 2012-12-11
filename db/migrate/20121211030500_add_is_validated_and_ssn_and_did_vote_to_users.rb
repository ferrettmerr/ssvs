class AddIsValidatedAndSsnAndDidVoteToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :is_validated, :boolean
  	add_column :users, :ssn, :string
  	add_column :users, :did_vote, :boolean

  end
  def down
  	remove_column :users, :is_validated
  	remove_column :users, :ssn
  	remove_column :users, :did_vote
  end
end
