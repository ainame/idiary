class CreateDiaries < ActiveRecord::Migration
  def self.up
    create_table :diaries do |t|
      t.string :screen_name
      t.integer :user_id
      t.text, :title
      t.text, :body
      t.text :photo_url_1
      t.text :photo_url_2
      t.text :photo_url_3

      t.timestamps
    end
  end

  def self.down
    drop_table :diaries
  end
end
