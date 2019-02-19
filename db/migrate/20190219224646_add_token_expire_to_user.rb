class AddTokenExpireToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token_expire, :datetime
  end
end
