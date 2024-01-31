class Investment < ApplicationRecord
  belongs_to :cryptocurrency

  def calculate_annual_return
    monthly_return_rate = case cryptocurrency.symbol
                          when 'BTC' then 0.05
                          when 'ETH' then 0.042
                          when 'ADA' then 0.01
                          else 0
                          end

    initial_amount = amount
    annual_return = initial_amount * (1 + monthly_return_rate)**12 - initial_amount
    annual_return.round(2)
  end
end
