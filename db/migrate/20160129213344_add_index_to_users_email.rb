class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true #  Миграция для реализации уникальности 
  	                                       # адреса электронной почты
  end
end
