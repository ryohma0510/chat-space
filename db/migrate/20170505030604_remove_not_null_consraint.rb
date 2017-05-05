class RemoveNotNullConsraint < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :content, :string, null: true
  end
end
