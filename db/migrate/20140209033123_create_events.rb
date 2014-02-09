class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :guid
      t.string :title
      t.string :description
      t.date :date
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.text :long_description

      t.timestamps
    end
  end
end
