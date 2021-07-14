# frozen_string_literal: true

class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = ENV['SECRET_KEY_BASE']

  def self.encode(payload, exp = 30.days.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET, false, { algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new(body)
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end
