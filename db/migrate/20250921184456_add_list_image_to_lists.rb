class AddListImageToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :list_image, :string
  end
end
