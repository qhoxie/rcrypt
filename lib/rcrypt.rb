require 'openssl'
require 'base64'

class RCrypt
  class << self
    %w{private public}.each do |type|
      name = :"#{type}_key"
      define_method(name) do
        instance_variable_get "@#{name}"
      end

      define_method(:"#{name}=") do |key_text|
        instance_variable_set "@#{name}", key_text
      end

      define_method(:"#{name}_file") do |key_file|
        path = File.expand_path(key_file)
        raise CryptException.new("Key file is not readable.") unless File.readable?(path)
        send :"#{name}=", File.read(path)
      end
    end

    def reset!
      @key_pair = @private_key = @public_key = nil
    end

    def generate_key_pair
      return @key_pair if @key_pair
      pair = OpenSSL::PKey::RSA.generate(2048)
      @private_key, @public_key = [pair.to_pem, pair.public_key.to_pem]
      @key_pair = {:private => @private_key, :public => @public_key}
    end

    def decrypt(plaintext, priv_key = @private_key)
      raise CryptException.new("No private key specified.") unless priv_key
      key(priv_key).private_decrypt Base64.decode64(plaintext)
    end

    def encrypt(plaintext, pub_key = @public_key)
      raise CryptException.new("No public key specified.") unless pub_key
      Base64.encode64 key(pub_key).public_encrypt(plaintext)
    end

    def key(key_text)
      OpenSSL::PKey::RSA.new key_text
    end
  end

  class CryptException < Exception; end
end
