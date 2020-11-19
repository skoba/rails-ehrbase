class AddColumnParty < ActiveRecord::Migration[6.0]
  def change
    add_column :parties, :ehr_id, :string
    add_column :parties, :uuid, :string
  end
end
