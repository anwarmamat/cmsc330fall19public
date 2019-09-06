# add_num takes an array of integers called arr
# and an integer called num, which it must add
# to each element in the array and print the result
# Example: add_num([1,2,3], 2) would print 3//4//5
def add_num(arr, num)
	# Your code here
end


# You are given a function that is passed a hash
# which is a simplified representation of a day's worth
# of Chipotle orders. If on a given day Chipotle sells
# 400 bowls worth $7.15 (veggie), 200 bowls worth $8.25 (steak)
# 50 guacs worth $2.15, and 50 chips worth $1.45, the hash will be
# {7.15=>400, 8.25=>200, 2.15=>50, 1.45=>50}.
# Return the total sales generated as a single float.
def chipotle_sales(receipts)
	# Your code here
end



# Below is a simplified Set class.
# Internally, we have chosen to represent a set as an array.
# The user may only interact with the Set through the public methods.
# Write the method .each for the Set class below.
# Most of the class has been implemented for your reference
class Set

	def initialize()
		@set = []
	end

	def insert(x)
		if not @set.include? x
			@set << x
		end
		return self
	end

	def size()
		return @set.length  #or @set.size
	end

	def remove(x)
		@set.delete x
		return self
	end

	def clear()
		@set = []
		return self
	end

	def union(x)
		x.each do |elem|
			self.insert(elem)
		end
		return self
	end

	def each
		# Your code here
	end
end


# Takes a string and returns true if the string represents a decimal
# and false otherwise
# Valid examples: “+1.0”, “+1”, “-124.124”, “1”, "-1"
# Invalid examples: “1,000.0”, “1.1.1”
def is_decimal(str)
	# Your code here
end


# Takes a String str. See this format:
#
# name: Firstname Lastname, grade: XX.XX
# * where "Firstname" and "Lastname" can be any string which starts with an
#   uppercase letter and has 0 or more lowercase letters afterwards.
# * where "XX.XX" can be any string representing a possible grade.
# * where everything else has to be exactly the same.
# * NOTE: A possible grade is defined to be a grade in the range [0.00, 100.00]
#   (inclusive). All grades will be reported to two decimal places, even if the
#   last digit is a 0, and end with a % symbol as shown in the examples below.
#
# If str has this format, then return a Hash with 2 key-value pairs: The 1st
# is :name mapped to the student's name (e.g. "Firstname Lastname") and the
# 2nd is :grade mapped to the student's grade (e.g. "23.15").
#
# If str doesn't have this format, return :error.
#
# e.g.
# extract_student_grades("name: Anwar Mamat, grade: 82.12%") ->
#   { :name => "Anwar Mamat", :grade => "82.12" }
# extract_student_grades("Nom: Anwar Mamat, grade: 82.12%") ->
#   :error
def extract_student_grades(str)
	# Your code here
end
