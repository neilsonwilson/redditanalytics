class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :link_id
      t.string :description

      t.timestamps
    end
  end
end
