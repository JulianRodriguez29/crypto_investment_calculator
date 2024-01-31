
class CryptocurrenciesController < ApplicationController
  before_action :set_cryptocurrencies, only: [:export_json, :export_csv]

  def index
    @cryptocurrencies = Cryptocurrency.all
  end
end
