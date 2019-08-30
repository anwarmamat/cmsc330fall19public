require "minitest/autorun"
require_relative "disc1.rb"

class Tests < Minitest::Test # must extend
    def setup # run before each test
        @obj = Functions.new
    end

    def test_shift_letters
    	assert_equal([], @obj.shift_letters([]))
    	assert_equal(['b','c','d', 'z'], @obj.shift_letters(['a','b','c','y']))
        assert_equal(['q'], @obj.shift_letters(['p']))
    end

    def test_add_to_inventory
    	assert_equal({"avocado"=>12, "apple"=>5, "tide pod"=>2}, @obj.add_to_inventory({"avocado"=>2, "apple"=>5}, {"avocado"=>10, "tide pod"=>2}))
        assert_equal({}, @obj.add_to_inventory({},{}))
        assert_equal({"Ben&Jerrys"=>1}, @obj.add_to_inventory({}, {"Ben&Jerrys"=>1}))
    end

    def test_wordcount
    	str1 = "I love Harambe and Harambe love me"
    	str2 = "330 is best"
    	str3 = "<3 going to class"
        str4 = "a a a a a a"
    	wc1 = WordCount.new(str1)
    	wc2 = WordCount.new(str2)
    	wc3 = WordCount.new(str3)
    	assert_equal({"I"=>1, "love"=>2, "Harambe"=>2, "and"=>1, "me"=>1}, wc1.getWordCount())
    	assert_equal([str1, str2, str3], WordCount.getHistory())
        assert_equal({"330"=>1, "is"=>1, "best"=>1}, wc2.getWordCount())
        assert_equal({"<3"=>1, "going"=>1, "to"=>1, "class"=>1}, wc3.getWordCount())
        wc4 = WordCount.new(str4)
        assert_equal({"a"=>6}, wc4.getWordCount())
        assert_equal([str1, str2, str3, str4], WordCount.getHistory())
    end
end