class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    # emailにindex追加、emailにユニークキー追加
    add_index :users, :email, unique: true
  end
end
