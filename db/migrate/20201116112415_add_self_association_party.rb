class AddSelfAssociationParty < ActiveRecord::Migration[6.0]
  def change
    add_reference :parties, :party, foreign_key: true
  end
end
