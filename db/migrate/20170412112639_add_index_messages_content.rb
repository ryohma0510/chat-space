class AddIndexMessagesContent < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, :content
  end
end
