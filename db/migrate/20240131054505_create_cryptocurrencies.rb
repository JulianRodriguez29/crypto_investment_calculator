class CreateCryptocurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :cryptocurrencies do |t|
      t.string :name
      t.string :symbol
      t.float :current_price

      t.timestamps
    end
  end
end
