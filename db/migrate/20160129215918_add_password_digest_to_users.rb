class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string # Миграция для добавления
                                       # столбца password_digest к таблице 
  end
end
