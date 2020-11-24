class CreatePartyIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :party_identities do |t|
      t.string :name
      t.references :party, null: false, foreign_key: true
      t.string :purpose

      t.timestamps
    end
  end
end
