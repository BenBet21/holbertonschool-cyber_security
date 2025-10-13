#!/usr/bin/env ruby

require 'prime'

# Checks if a given number is prime.
# Returns true if number is prime, false otherwise.
def prime(number)
	return false unless number.is_a?(Integer)
	return false if number < 2

	Prime.prime?(number)
end
