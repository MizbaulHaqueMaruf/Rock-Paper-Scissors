require 'securerandom'
require 'openssl'

class Security
  def generate_key
    SecureRandom.hex(32)
  end

  def generate_hmac(key, message)
    hmac = OpenSSL::HMAC.digest('sha256', key, message)
    hmac.unpack1('H*')
  end
end
