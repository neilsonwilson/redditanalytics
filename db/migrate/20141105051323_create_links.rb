class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.integer :issubreddit
      t.string :keyword

      t.timestamps
    end
  end
end
