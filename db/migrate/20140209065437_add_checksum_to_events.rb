class AddChecksumToEvents < ActiveRecord::Migration
  def change
    add_column :events, :checksum, :string
  end
end
