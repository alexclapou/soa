# app/controllers/concerns/jwt_concern.rb
module JwtConcern
  extend ActiveSupport::Concern

  def encode_token(payload)
    JWT.encode(payload, 'very-secret-key')
  end

  def decode_token(token)
    JWT.decode(token, 'very-secret-key').first
  end

  def auth_payload
    @auth_payload ||= decode_token(request.headers['Authorization'])
  end
end
