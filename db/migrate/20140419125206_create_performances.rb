class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :rating
      t.integer :volatility

      t.timestamps
    end
  end
end
