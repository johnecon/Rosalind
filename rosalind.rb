require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'

class OptparseExample

	CODES = %w[iso-2022-jp shift_jis euc-jp utf8 binary]
	CODE_ALIASES = { "jis" => "iso-2022-jp", "sjis" => "shift_jis" }

	def self.parse(args)
		options = OpenStruct.new
		options.library = []
		options.inplace = false
		options.encoding = "utf8"
		options.transfer_type = :auto
		options.verbose = false

		opts = OptionParser.new do |opts|
			opts.banner = "Usage: example.rb [options]"

			opts.separator ""
			opts.separator "Specific options:"

			# Optional argument; multi-line description.
			opts.on("-s", "--string [DNA_String]",
			      "DNA string") do |s|
			options.string = s
			options.extension = s || ''
			end
			opts.on("-e", "--expectedvalue [Expected_Value]",
			      "Expected Value") do |e|
			options.expectedvalue = e
			options.extension = e || ''
			end
			opts.on("-m", "--matrix [Matrix]",
			      "Matrix") do |m|
			options.matrix = m
			options.extension = m || ''
			end
			opts.on("-d", "--genomesearch [Searching_Genome]",
			      "Genome search") do |d|
			options.genomesearch = d
			options.extension = d || ''
			end
			opts.on("-n", "--geneticcode [Genetic_Code]",
			      "Genetic code") do |n|
			options.geneticcode = n
			options.extension = n || ''
			end

			opts.on("-g", "--gccontent [DNA_String]",
			      "G content") do |g|
			options.gccontent = g
			options.extension = g || ''
			end
			opts.on("-h", "--hammingd  [hamming distance]",
			      "Hamming distance") do |h|
			options.hammingd = h
			options.extension = h || ''
			end

			opts.on("-p", "--permutation  [permutations]",
			      "Permutations") do |p|
			options.permutation = p
			options.extension = p || ''
			end

			# Optional argument; multi-line description.
			opts.on("-f", "--fasta [Fasta_DNA_Strings]",
			      "Set of DNA strings in fasta format") do |f|
			options.fasta = f
			options.extension = f || ''
			end

			opts.on_tail("-h", "--help", "Show this message") do
				puts opts
				exit
			end
		end
		opts.parse!(args)
		options
	end
end

options = OptparseExample.parse(ARGV)
string = options.string
fasta_arg = options.fasta
hamming_distance_arg = options.hammingd
permutation = options.permutation
gc_content_arg = options.gccontent
genetic_code_arg = options.geneticcode
genome_search_arg = options.genomesearch
matrix_arg = options.matrix
expected_value_arg = options.expectedvalue
if string
	dna = DNA.new(string)
	dna.set_string(string)
end
if fasta_arg
	dnas = Hash.new()
	fasta_array = fasta_arg.strip.gsub(/\n/, '').split('>Rosalind_')
	for fasta in fasta_array
		if fasta != ""
			prefix = fasta[0...4]
			dnas[prefix] = DNA.new(fasta.split(prefix)[1])
		end
	end
	maximumGC = -1
	maximumGCPrefix = nil
	maximumGCDNA = nil
	dnas.each do |prefix, dna|
		sum = dna.get_string('G') + dna.get_string('C')
		if sum > maximumGC
			maximumGCPrefix = prefix
			maximumGCDNA = dna
			maximumGC = sum
		end
	end
	# percentage = ((maximumGC.fdiv(maximumGCDNA.get_string.length) - 0.000001) * 10000000).to_int().fdiv(100000)
	percentage = maximumGC.fdiv(maximumGCDNA.get_string.length) * 100 - 0.0001
	puts "Rosalind_#{maximumGCPrefix} \n#{percentage}%"
end
if hamming_distance_arg
	h = Hash.new()
	i = 0
	string_one, string_two = hamming_distance_arg.split(',')
	string_one.split("").each do |char_string_one|
		h[i] = char_string_one
		i = i + 1
	end
	i = 0
	hamming_distance = 0
	string_two.split("").each do |char_string_two|
		if h[i] != char_string_two
			hamming_distance = hamming_distance + 1
		end
		i = i + 1
	end
	pp hamming_distance
end
if permutation
	permutations = (1..permutation.to_i).to_a.permutation(permutation.to_i).to_a
	pp permutations.length
	permutations.each do |element_permutation|
		element_permutation.each do |char|
			print char
			print ' '
		end
		puts ''
	end
end
if gc_content_arg
	gc_contents = gc_content_arg.split(" ")
	gc_contents.each do |gc_content|
		print "#{(gc_content.to_f.fdiv(2)**2 + (1 - gc_content.to_f).fdiv(2)**2) * 2} "
	end
end
if genetic_code_arg
	rna = RNA.new()
	rna_codon_table = rna.rna_codon_table
	genetic_code_array = genetic_code_arg.split('')
	length = genetic_code_arg.length
	j = 0
	begin
		i = j
		prefix = ''
		begin
		   prefix += genetic_code_array[i]
		   i += 1
		end while i < j + 3 and genetic_code_array[i] != nil
		if rna_codon_table[prefix] == ''
			break
		end
		print rna_codon_table[prefix]
		j += 3
	end while j < length
end
if genome_search_arg
	genome_search_args = genome_search_arg.split(" ")
	i = 0
	length = genome_search_args[0].length
	a = 0
	begin
		a = genome_search_args[0].index(genome_search_args[1], a) + 1
		print "#{a} "
		i += 1
	end while i<length
end
if matrix_arg
	matrix = Matrix.new(matrix_arg.split(' '))
	matrix.scan_dnas_and_set_labels
	matrix.get_matrix_output
end
if expected_value_arg
	n = 8549
	m = 9
	gc_contents = expected_value_arg.split(' ')
	gc_contents.each do |gc_content|
		expected_value = ((gc_content.to_f.fdiv(2)**2 + (1 - gc_content.to_f).fdiv(2)**2) * 2)**m*(n+1-m)
		rounded = (expected_value * 1000000).round() / 1000000.0
		print "#{rounded} "
	end
end

