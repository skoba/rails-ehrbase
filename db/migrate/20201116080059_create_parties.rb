class CreateParties < ActiveRecord::Migration[6.0]
  def change
    create_table :parties do |t|
      t.string :rm_type

      t.timestamps
    end
  end
end
