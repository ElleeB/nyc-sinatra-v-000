class CreateLandmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :landmarks do |t|
      t.string :name
      t.integer :year_completed
      t.integer :figure_id
    end
  end
end
