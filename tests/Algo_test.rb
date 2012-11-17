require 'test/unit'
require '~/project/Rosalind/Algo.rb'
require 'pp'

class TestAlgo < Test::Unit::TestCase
	def test_sign
		assert_equal [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]], Algo.sign(2)
	end
end