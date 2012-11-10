class Matrix
	attr_accessor :dnas, :labels
	def initialize(dnas)
		@dnas = dnas
	end
	def get_count_for_char_in_line(char, line)
		counter = 0
		@dnas.each do |dna|
			if dna[line].chr == char
				counter += 1
			end
		end
		counter
	end
	def longest_common_substr()
		strings = Array.new
		@dnas.each do |dna|
			strings.push(dna.get_string)
		end
		shortest = strings.min_by {|x| x.length}
		maximum_length = shortest.length
		i = maximum_length
		while i >= 1
			j = 0
			while j<= maximum_length - i
				substr = shortest[j,i]
				return substr if strings.all?{|str| str.include? substr }
				j += 1
			end
			i -= 1
		end
	end
	def scan_dnas_and_set_labels
		@labels = ''
		winner = Hash.new
		maxOccurances = Hash.new
		maxOccurances['A'] = 0
		maxOccurances['G'] = 0
		maxOccurances['C'] = 0
		maxOccurances['T'] = 0
		@dnas.each do |dna|
			i = 0
			dna.each_char do |char|
				count = get_count_for_char_in_line(char, i)
				if maxOccurances[char] < count
					maxOccurances[char] = count
				end
				i += 1
			end
		end
		maxOccurances.sort_by {|k, v| v}
		maxOccurances.each do |k, v|
			@labels.insert(-1, k)
		end
		i = 0
		winner_char = ''
		@dnas[0].each_char do |char|
			winner_count = 0
			@labels.each_char do |label|
				count = get_count_for_char_in_line(label, i)
				if winner_count < count
					winner_count = count
					winner_char = label
				end
			end
			winner[i] = winner_char
			i += 1
		end
		sorted_keys = winner.keys.sort
		sorted_keys.each do |key|
			print "#{winner[key]}"
		end
		puts ''
	end
	def get_matrix_output
		@labels.each_char do |label|
			counter = 0
			length = @dnas[0].length
			print "#{label}: "
			begin
				print get_count_for_char_in_line(label, counter)
				print ' '
				counter +=1
			end while counter < length
			puts ''
		end
	end
end