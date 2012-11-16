require '~/project/Rosalind/RNA.rb'
class DNA
	attr_accessor :string, :reverse, :reverse_complement, :fasta_prefix
	def initialize(string = nil)
		@string = string
		if (string)
			@reverse = string.reverse
			@reverse_complement = @reverse.gsub(/(T)/, 'a').gsub(/(A)/, 't').gsub(/(C)/, 'g').gsub(/(G)/, 'c').gsub(/(a)/, 'A').gsub(/(t)/, 'T').gsub(/(g)/, 'G').gsub(/(c)/, 'C')
		end
	end
	def get_string(char = nil)
		if char == nil
			return @string
		else
			return @string.count(char)
		end
	end
	def self.is_reverse_palindrome(string)
		string == string.reverse.gsub(/(T)/, 'a').gsub(/(A)/, 't').gsub(/(C)/, 'g').gsub(/(G)/, 'c').gsub(/(a)/, 'A').gsub(/(t)/, 'T').gsub(/(g)/, 'G').gsub(/(c)/, 'C')
	end
	def revp
		revp = []
		0.upto(@string.length) do |i|
			3.upto(7) do |j|
				revp.push([i + 1, j + 1]) if ((DNA.is_reverse_palindrome(@string[i..(i+j)]) and ((i + j) < @string.length)))
			end
		end
		# revp.each do |r|
		# 	print r[0]
		# 	print ' '
		# 	print r[1]
		# 	puts ''
		# end
		revp
	end
	def get_failure_array
		string = ''
		failure_array = Hash.new()
		j = 0
		begin
			failure_array[j] = 0
			j += 1
		end while j < @string.length
		j = 1
		while j < @string.length
			i = failure_array[j-1]
			while i >= 0
				if @string[(j-i)..j] == @string[0..i]
					failure_array[j] = i+1
					break
				end
				i -= 1
			end
			j += 1
		end
		sorted_values = failure_array.sort
		sorted_values.each do |key, val|
			string += "#{val} "
		end
		string
	end
	# credits go to http://computersciencesource.wordpress.com/2011/01/03/string-searching-the-knuth-morris-pratt-algorithm/
	def kmp_table()
		w = @string
		i = 2
		sub = 0
		t = [-1, 0]
		wlen = w.length
		while i < wlen
			if w[i-1] == w[sub]
				sub += 1
				t[i] = sub
				i += 1
			elsif sub > 0
				sub = t[sub]
			else
				t[i] = 0
				i += 1
			end
		end
		t
	end
	def kmp_search(w)
		s = @string
		m = i = 0
		slen = s.length
		wlen = w.length
		t = self.kmp_table()
		while m + i < slen
			if w[i] == s[m+i]
				i += 1
				return m  if i == wlen
			else
				m += i - t[i]
				i = [0, t[i]].max
			end
		end
		-1
	end
	def get_common_substrings(dna)
		string = @string
		length = 0
		comparing_string = dna.get_string
		i = 0
		matching_strings = Array.new()
		while i < string.length
			j = i + 1
			while j < string.length
				testing_string = string[i..j]
				# pp testing_string
				if dna.kmp_search(testing_string) != -1
					matching_strings.push(testing_string)
				end
				j += 1
			end
			i += 1
		end
		# sorted_matching_strings = Hash.new([])
		# # arr = matching_strings.sort_by {|x| x.length}
		# prev_length = 0
		# matching_strings.each do |s|
		# 	if sorted_matching_strings[s.length] != []
		# 		sorted_matching_strings[s.length].push(s)
		# 	elsif !sorted_matching_strings[s.length].include?(s)
		# 		sorted_matching_strings[s.length] = [s]
		# 	end
		# end
		# sorted_matching_strings
	end
	def get_rna()
		@string.gsub(/(T)/, 'U')
	end
	def get_reverse_complement()
		@reverse_complement
	end
	def set_string(string)
		@string = string
	end
	def get_reverse()
		@reverse
	end
	def set_fasta_prefix(prefix)
		@fasta_prefix = prefix
	end
	def get_fasta_prefix()
		@fasta_prefix
	end
	def get_last(k)
		@string[-k,k]
	end
	def orf
		condon_table = RNA.rna_codon_table
		write_mode = false
		length = @string.length
		string = @string.gsub(/(T)/, 'U')
		j = 0
		buffer = Array.new
		out = Array.new
		starting_condon = 'AUG'
		0.upto(2) do |h|
			i = 0 + h
			while i <= length
				testing_string = string[i..(i + 2)]
				if condon_table[testing_string] == '' and buffer != [] and write_mode
					out.push(buffer)
					buffer = []
					j = 0
					write_mode = false
				elsif testing_string == starting_condon and !write_mode
					write_mode = true
				end
				if write_mode
					buffer[j] = condon_table[testing_string]
					j += 1
				end
				i += 3
			end
		end
		out
	end
end