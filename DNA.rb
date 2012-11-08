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
	def get_failure_array
		# failure_array = Hash.new()
		# j = 0
		# begin
		# 	failure_array[j] = 0
		# 	j += 1
		# end while j < @string.length
		# j = 0
		# i = 4
		# while j < i
		# 	i = 2 * j
		# 	if (i == 0 or i == 2)
		# 		i = 4
		# 	end
		# 	while i < @string.length
		# 		h = j
		# 		count = 0
		# 		should_update = true
		# 		while h <= j
		# 			if @string[h] == @string[i-j+h]
		# 				count += 1
		# 			else
		# 				h = j
		# 			end
		# 			h += 1
		# 		end
		# 		if should_update
		# 			failure_array[i] += count
		# 		end
		# 		i += 1
		# 	end
		# 	j += 1
		# end
		# string = ''
		# sorted_values = failure_array.sort
		# sorted_values.each do |key, val|
		# 	string += "#{val} "
		# end
		# string





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
end