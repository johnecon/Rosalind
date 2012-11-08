require '/Users/john/project/rozalind/DNA.rb'
require 'pp'

class Graph
	attr_accessor :edges, :dnas
	def initialize(dnas)
		@dnas = dnas
	end
	def build_edges(k)
		@edges = Hash.new
		i = 0
		sorted_keys = @dnas.keys.sort
		sorted_keys.each do |order|
			dna = @dnas[order]
			prefix = dna.get_fasta_prefix
			testing_string = dna.get_string[0...k]
			testing_last_k = dna.get_last(k)
			nested_sorted_keys = @dnas.keys.sort
			nested_sorted_keys.each do |nested_order|
				if nested_order != order
					nested_dna = @dnas[nested_order]
					if testing_last_k == nested_dna.get_string[0...k]
						nested_prefix = nested_dna.get_fasta_prefix
						@edges[i] = "Rosalind_#{prefix} Rosalind_#{nested_prefix}"
						i += 1
					end
				end
			end
		end
	end
	def get_edges()
		@edges
	end
end

fasta_arg = ARGV[0]
dnas = Hash.new()
fasta_array = fasta_arg.strip.gsub(/\n/, '').split('>Rosalind_')
i = 0
for fasta in fasta_array
	if fasta != ""
		prefix = fasta[0...4]
		dna = DNA.new(fasta.split(prefix)[1])
		dna.set_fasta_prefix(prefix)
		dnas[i] = dna
		i += 1
	end
end
graph = Graph.new(dnas)
graph.build_edges(3)
edges = graph.get_edges
sorted_keys = edges.keys.sort
sorted_keys.each do |i|
	print edges[i]
	puts ''
end