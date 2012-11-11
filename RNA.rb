class RNA
	attr_accessor :rna_codon_table, :protein_string
	def initialize(protein_string = nil)
		if (protein_string)
			@protein_string = protein_string
		end
	end
	def number_of_possible_rna_translations
		@rna_codon_table = self.class.rna_codon_table
		number_of_possible_rna_translations = 1
		codon_array = @rna_codon_table.values
		@protein_string.each_char do |char|
			number_of_possible_rna_translations *= codon_array.count(char)
		end
		number_of_possible_rna_translations = number_of_possible_rna_translations * 3
		number_of_possible_rna_translations % 1000000
	end
	def self.rna_codon_table
		if @rna_codon_table
			return @rna_codon_table
		else
			@rna_codon_table = Hash.new()
			@rna_codon_table['GCC'] = 'A'
			@rna_codon_table['GCA'] = 'A'
			@rna_codon_table['GCG'] = 'A'
			@rna_codon_table['GAU'] = 'D'
			@rna_codon_table['GAC'] = 'D'
			@rna_codon_table['GAA'] = 'E'
			@rna_codon_table['GAG'] = 'E'
			@rna_codon_table['GGU'] = 'G'
			@rna_codon_table['GGC'] = 'G'
			@rna_codon_table['GGA'] = 'G'
			@rna_codon_table['GGG'] = 'G'
			@rna_codon_table['ACC'] = 'T'
			@rna_codon_table['ACA'] = 'T'
			@rna_codon_table['ACG'] = 'T'
			@rna_codon_table['AAU'] = 'N'
			@rna_codon_table['AAC'] = 'N'
			@rna_codon_table['AAA'] = 'K'
			@rna_codon_table['AAG'] = 'K'
			@rna_codon_table['AGU'] = 'S'
			@rna_codon_table['AGC'] = 'S'
			@rna_codon_table['AGA'] = 'R'
			@rna_codon_table['AGG'] = 'R'
			@rna_codon_table['CCC'] = 'P'
			@rna_codon_table['CCA'] = 'P'
			@rna_codon_table['CCG'] = 'P'
			@rna_codon_table['CAU'] = 'H'
			@rna_codon_table['CAC'] = 'H'
			@rna_codon_table['CAA'] = 'Q'
			@rna_codon_table['CAG'] = 'Q'
			@rna_codon_table['CGU'] = 'R'
			@rna_codon_table['CGC'] = 'R'
			@rna_codon_table['CGA'] = 'R'
			@rna_codon_table['CGG'] = 'R'
			@rna_codon_table['UUU'] = 'F'
			@rna_codon_table['CUU'] = 'L'
			@rna_codon_table['AUU'] = 'I'
			@rna_codon_table['GUU'] = 'V'
			@rna_codon_table['UUC'] = 'F'
			@rna_codon_table['CUC'] = 'L'
			@rna_codon_table['AUC'] = 'I'
			@rna_codon_table['GUC'] = 'V'
			@rna_codon_table['UUA'] = 'L'
			@rna_codon_table['CUA'] = 'L'
			@rna_codon_table['AUA'] = 'I'
			@rna_codon_table['GUA'] = 'V'
			@rna_codon_table['UUG'] = 'L'
			@rna_codon_table['CUG'] = 'L'
			@rna_codon_table['AUG'] = 'M'
			@rna_codon_table['GUG'] = 'V'
			@rna_codon_table['UCU'] = 'S'
			@rna_codon_table['CCU'] = 'P'
			@rna_codon_table['ACU'] = 'T'
			@rna_codon_table['GCU'] = 'A'
			@rna_codon_table['UCC'] = 'S'
			@rna_codon_table['UCA'] = 'S'
			@rna_codon_table['UCG'] = 'S'
			@rna_codon_table['UAU'] = 'Y'
			@rna_codon_table['UAC'] = 'Y'
			@rna_codon_table['UAA'] = ''
			@rna_codon_table['UAG'] = ''
			@rna_codon_table['UGU'] = 'C'
			@rna_codon_table['UGC'] = 'C'
			@rna_codon_table['UGA'] = ''
			@rna_codon_table['UGG'] = 'W'
			@rna_codon_table['UUU'] = 'F'
			return @rna_codon_table
		end
	end
end