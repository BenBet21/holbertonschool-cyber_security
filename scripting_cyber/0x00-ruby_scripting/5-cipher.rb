#!/usr/bin/env ruby

# CaesarCipher class implements a simple Caesar cipher
class CaesarCipher
  def initialize(shift)
    @shift = shift % 26
  end

  def encrypt(message)
    cipher(message, @shift)
  end

  def decrypt(message)
    cipher(message, -@shift)
  end

  private

  def cipher(message, shift)
    result = message.chars.map do |ch|
      if ch =~ /[A-Za-z]/
        base = ch =~ /[A-Z]/ ? 'A'.ord : 'a'.ord
        (((ch.ord - base) + shift) % 26 + base).chr
      else
        ch
      end
    end

    result.join
  end
end
