class CreateFigures < ActiveRecord::Migration[4.2]

  def change
    create_table :landmarks do |t|
      t.string :name
    end
  end
  
end
