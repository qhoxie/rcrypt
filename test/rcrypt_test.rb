require 'test_helper'

class RCryptTest < Test::Unit::TestCase
  def from_generated
    RCrypt.generate_key_pair
  end

  def from_file
    RCrypt.public_key_file File.join(FIXTURES_DIR, "id_rsa.pub")
    RCrypt.private_key_file File.join(FIXTURES_DIR, "id_rsa")
  end

  context "Encrypting and decrypting data" do
    setup do
      @plaintext = "secret"
    end

    %w{generated file}.each do |in_type|
      context "with #{in_type} keys" do
        setup do
          RCrypt.reset!
          send :"from_#{in_type}"
        end

        %w{private public}.each do |key_type|
          should "have a #{key_type} key present" do
            assert RCrypt.send(:"#{key_type}_key")
          end
        end

        should "encrypt to ciphertext" do
          assert RCrypt.encrypt(@plaintext).length
        end

        should "decrypt to plaintext" do
          ciphertext = RCrypt.encrypt(@plaintext)
          assert_equal RCrypt.decrypt(ciphertext), @plaintext
        end
      end
    end
  end
end
