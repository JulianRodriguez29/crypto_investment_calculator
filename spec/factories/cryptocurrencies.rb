FactoryBot.define do
  factory :cryptocurrency do
    name { 'Bitcoin' }
    symbol { 'BTC' }
    current_price { 50000.0 }
  end
end