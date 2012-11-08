require '/Users/john/project/rozalind/DNA.rb'
require 'pp'

dna_string = ARGV[0]
dna = DNA.new(dna_string)
pp dna.get_failure_array