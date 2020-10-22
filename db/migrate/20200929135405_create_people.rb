class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :ehr_id
      t.string :uuid

      t.timestamps
    end
  end
end
