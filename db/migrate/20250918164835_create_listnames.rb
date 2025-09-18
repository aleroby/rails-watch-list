class CreateListnames < ActiveRecord::Migration[7.1]
  def change
    create_table :listnames do |t|

      t.timestamps
    end
  end
end
