require 'test/unit'
require '~/project/Rosalind/RNA.rb'
require 'pp'

class TestRNA < Test::Unit::TestCase
	def test_mrna
		rna = RNA.new('MA')
		assert_equal 12, rna.number_of_possible_rna_translations
	end
end
