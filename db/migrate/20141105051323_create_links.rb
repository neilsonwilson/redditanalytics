class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.int :issubreddit
      t.string :keyword

      t.timestamps
    end
  end
end
