class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
<<<<<<< HEAD
      t.integer :issubreddit
=======
      t.int :issubreddit
>>>>>>> 36f0852365eba4e337e250e7a6127a4144b19b0c
      t.string :keyword

      t.timestamps
    end
  end
end
