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
	# def test_perm
	# 	permutations = ('T A G C').split(' ').repeated_permutation(2).to_a
	# 	assert_equal [["T", "T"], ["T", "A"], ["T", "G"],
	# 	["T", "C"], ["A", "T"], ["A", "A"], ["A", "G"],
	# 	["A", "C"], ["G", "T"], ["G", "A"], ["G", "G"],
	# 	["G", "C"], ["C", "T"], ["C", "A"], ["C", "G"], ["C", "C"]], permutations
	# end
	# def test_orf
	# 	dna = DNA.new('AGCCATGTAGCTAACTCAGGTTACATGGGGATGACCCCGCGACTTGGATTAGAGTCTCTTTTGGAATAAGCCTGAATGATCCGAGTAGCATCTCAG')
	# 	assert_equal '', dna.orf
	# end
	def test_is_reverse_palindrome
		assert DNA.is_reverse_palindrome('GCATGC')
	end
	def test_revp
		dna = DNA.new('TCAATGCATGCGGGTCTATATGCAT')
		assert_equal [[4, 6], [5, 4], [6, 6], [7, 4], [17, 4], [18, 4], [20, 6], [21, 4]], dna.revp
	end
end
