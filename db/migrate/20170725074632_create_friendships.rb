class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :sender
      t.integer :receiver
      t.boolean :accept

      t.timestamps
    end
  end
end
