class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :image_url, default: "https://bit.ly/2tlLmZc"
      t.string :spotify_token
      t.string :profile_url

      t.timestamps
    end
  end
end
