class CryptoChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'crypto_channel'
  end
end