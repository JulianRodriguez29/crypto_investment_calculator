class CreateInvestments < ActiveRecord::Migration[6.0]
  def change
    create_table :investments do |t|
      t.integer :cryptocurrency_id
      t.float :amount

      t.timestamps
    end
  end
end
