class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	# Листинг 8.16. Миграция для добавления remember_token к таблице users.
  	add_column :users, :remember_token, :string
    add_index  :users, :remember_token
  end
end
