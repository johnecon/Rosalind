require 'test/unit'
require '~/project/Rosalind/DNA.rb'
require 'pp'

class TestDNA < Test::Unit::TestCase
	def test_get_failure_array
		assert_equal "0 0 0 0 0 0 0 1 2 3 0 0 0 1 0 0 ", DNA.new('CAGTAAGCAGGGACTG').get_failure_array
	end

	def test_kmp_table
		assert_equal [-1, 0, 0, 0, 1, 0, 1, 0, 1, 2, 3], DNA.new('abracadabra').kmp_table()
	end

	def test_kmp_search
		assert_equal 5, DNA.new('abracabracadabra').kmp_search('abracadabra')
	end
end
