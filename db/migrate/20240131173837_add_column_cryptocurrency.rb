class AddColumnCryptocurrency < ActiveRecord::Migration[6.0]
  def change
    add_column :cryptocurrencies, :monthly_interest, :float
    add_column :cryptocurrencies, :balance, :float
  end
end
