class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :ehr_id
      t.string :uuid
      t.string :orca_id

      t.timestamps
    end
  end
end
