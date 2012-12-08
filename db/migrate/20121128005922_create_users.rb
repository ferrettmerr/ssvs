class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :ssn
      t.boolean :didVote

      t.timestamps
    end
  end
end
