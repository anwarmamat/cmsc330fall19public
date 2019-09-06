require "minitest/autorun"
require_relative "disc2.rb"

class Tests < Minitest::Test

    def test_chipotle_sales
    	assert_in_delta(5.0, chipotle_sales({2.5=>2}), 0.0001)
        assert_in_delta(0.0, chipotle_sales({}), 0.0001)
        assert_in_delta(4690.0, chipotle_sales({7.15=>400, 8.25=>200, 2.15=>50, 1.45=>50}), 0.0001)
    end

    def test_set
        set = Set.new()
        set.insert(1).insert(2).insert(3).insert(4).insert(5)

        sum = 0
        set.each do |x|
            sum += x
        end
        assert_equal(15, sum)

        set.remove(2).remove(4)
        set.each do |x|
            if x.even?
                flunk()
            end
        end

        set.clear()
        set.insert("Testudo").insert("Terrapin").insert("Terp")
        arr = []
        set.each do |x|
            arr << x
        end

        assert_equal(3, arr.length)
        assert(arr.include? "Testudo")
        assert(arr.include? "Terrapin")
        assert(arr.include? "Terp")
    end

    def test_is_decimal
        assert(is_decimal("+1.0"))
        assert(is_decimal("+1"))
        assert(is_decimal("-124.124"))
        assert(is_decimal("1"))
        assert(is_decimal("-1"))
        refute(is_decimal("1,000.0"))
        refute(is_decimal("1.1.1"))
    end

    def test_extra_student_grades
        assert_equal({ :name => "Anwar Mamat", :grade => "100.00" }, extract_student_grades("name: Anwar Mamat, grade: 100.00%"))
        assert_equal({ :name => "Anwar Mamat", :grade => "82.12" }, extract_student_grades("name: Anwar Mamat, grade: 82.12%"))
        assert_equal({ :name => "Anwar Mamat", :grade => "7.55" }, extract_student_grades("name: Anwar Mamat, grade: 7.55%"))
        assert_equal({ :name => "Anwar Mamat", :grade => "0.00" }, extract_student_grades("name: Anwar Mamat, grade: 0.00%"))

        assert_equal(:error, extract_student_grades("name: AnwarMamat, grade: 99.33%"))
        assert_equal(:error, extract_student_grades("name: anwar mamat, grade: 81.14%"))
        assert_equal(:error, extract_student_grades("name: anwar0 mamat, grade: 14.55%"))

        assert_equal(:error, extract_student_grades("name: Anwar Mamat, grade: 14a55%"))
        assert_equal(:error, extract_student_grades("name: Anwar Mamat, grade: 100.12%"))
        assert_equal(:error, extract_student_grades("name: Anwar Mamat, grade: 1000.12%"))
        assert_equal(:error, extract_student_grades("name: Anwar Mamat, grade: "))
        assert_equal(:error, extract_student_grades("name: Anwar Mamat, grade:"))
        assert_equal(:error, extract_student_grades("name: Anwar Mamat, grade: 95.12% "))

        assert_equal(:error, extract_student_grades("name: Anwar Mamat,grade: 35.67%"))
        assert_equal(:error, extract_student_grades("name: Anwar Mamat grade: 62.44%"))
        assert_equal(:error, extract_student_grades("Name: Anwar Mamat, grade: 66.35%"))

    end

end
