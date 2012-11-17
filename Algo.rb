require '~/project/Rosalind/RNA.rb'
require '~/project/Rosalind/DNA.rb'

class Algo
	def self.multiply_arrays(a1, a2)
		a3 = Array.new()
		0.upto(a1.length - 1) do |i|
			if a2[i].to_i > 0
				a3[i] = a1[i] * a2[i].to_i * (-1)
			else
				a3[i] = a1[i]
			end
		end
		a3
	end
	def self.str_to_array(string)
		a = Array.new()
		string.each_char do |c|
			a.push(c.to_i)
		end
		a
	end
	def self.sign(integer)
		out = []
		permutations = (1..integer.to_i).to_a.permutation(integer).to_a
		permutations.each do |permutation|
			0.upto(3) do |i|
				out.push(Algo.multiply_arrays(permutation, Algo.str_to_array(sprintf "%02b", i)))
			end
		end
		out
		# puts out.length
		# out.each do |o|
		# 	o.each do |e|
		# 		print e
		# 		print ' '
		# 	end
		# 	puts ' '
		# end
		# exit
	end
end
