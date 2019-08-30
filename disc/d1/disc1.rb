class Functions

	# Write a method shift_letters that accepts a character array
	#  and returns a new character array where each letter is increased by 1
	# E.g. shift_letters(['a','b','c','y']) should return ['b','c','d','z']
	def shift_letters(ch_arr) 
		# code here
	end


	# Write a method add_to_inventory that takes a hash new_items
	#  and a hash old_items, adds new_items to old_items, and
	#  returns the updated old_inventory
	# E.g. add_to_inventory({"avocado"=>2, "apple"=>5}, {"avocado"=>10, "tide pod"=>2})
	#  should return {"avocado"=>12, "apple"=>5, "tide pod"=>2}
	def add_to_inventory(new_items, old_items)
		# code here
	end

end


# Write a class WordCount. The constructor takes a String named sentence.
# Write a method getWordCount that returns a hash mapping each word to how many times it appears.
# Write a static method getHistory that returns an array of all the sentences the WordCount class has ever gotten.
# E.g. wc1 = WordCount.new("I love Harambe and Harambe love me")
#      wc1.getWordCount()  # returns {"I"=>1, "love"=>2, "Harambe"=>2, "and"=>1, "me"=>1}
#      wc2 = WordCount.new("330 is best")
#      wc3 = WordCount.new("<3 going to class")
#      WordCount.getHistory()  # returns ["I love Harambe and Harambe love me", "330 is best", "<3 going to class"]
class WordCount

	def initialize(sentence)
		# code here
	end

	def getWordCount()
		# code here
	end

	# The self keyword is used to tell Ruby that the method is static
	def self.getHistory()
		# code here
	end
end
