require 'csv'

class InvestmentsController < ApplicationController

  before_action :fetch_crypto_prices, only: [:index, :new]

  def index
    @investments = Investment.all
  end
  
  def new
    @investment = Investment.new
  end

  def create
    @investment = Investment.new(investment_params)
    if @investment.save
      redirect_to root_path, notice: 'Inversión exitosa.'
    else
      render :new
    end
  end

  

  private

  def fetch_crypto_prices
    crypto_data = read_crypto_data_from_csv # Llamada a la función que lee el CSV
    update_crypto_instances(crypto_data)
  end

  def read_crypto_data_from_csv
    crypto_data = []
    CSV.foreach('./public/crypto_data.csv', headers: true) do |row|
      crypto_data << {
        name: row['Moneda'],
        monthly_interest: row['Interes_mensual'].to_f,
        balance: row['balance_ini'].to_f	
      }
    end
    crypto_data
  end

  def update_crypto_instances(crypto_data)
    crypto_data.each do |data|
      symbol = case data[:name]
                when 'Bitcoin' then 'BTC'
                when 'Ether' then 'ETH'
                when 'Cardano' then 'ADA'
                else ''
                end

      crypto = Cryptocurrency.find_or_create_by(name: data[:name])
      crypto.update(monthly_interest: data[:monthly_interest], balance: data[:balance], current_price: fetch_price(symbol), symbol: symbol)

      @bitcoin_price = crypto.current_price if crypto.symbol == 'BTC'
      @ether_price = crypto.current_price if crypto.symbol == 'ETH'
      @cardano_price = crypto.current_price if crypto.symbol == 'ADA'
    end
  end

  def fetch_price(crypto_symbol)
    response = HTTParty.get("https://rest.coinapi.io/v1/exchangerate/#{crypto_symbol}/USD",
                            headers: { 'X-CoinAPI-Key' => '3B62E8B4-C275-477E-A922-9F06164FF262' })
    JSON.parse(response.body)['rate'] if response.success?
  end

  

  def investment_params
    params.require(:investment).permit(:cryptocurrency_id, :amount)
  end


end
