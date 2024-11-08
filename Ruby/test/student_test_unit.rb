require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require_relative "../homework_1"

Minitest::Reporters.use! [
  Minitest::Reporters::HtmlReporter.new(
    reports_dir: 'test/result',
    output_filename: "UnitTests.html",
    clean: true,
    add_timestamp: true
  )
]

class StudentTest < Minitest::Test
  def teardown
    Student.class_variable_set(:@@students, [])
  end

  def setup
    @student1 = Student.new("Issac", "Carolina", Date.new(2000, 3, 9))
    @student2 = Student.new("Smith", "Yuriy", Date.new(2005, 9, 15))
    @student3 = Student.new("Jeanna", "Evalyn", Date.new(1999, 1, 1))
  end

  def test_student_initialization
    assert_equal "Issac", @student1.surname
    assert_equal "Carolina", @student1.name
    assert_equal Date.new(2000, 3, 9), @student1.date_of_birth
  end

  def test_calculate_age
    age = @student1.calculate_age
    assert_equal 24, age
  end

  def test_add_student
    initial_student_count = Student.students.size
    student = Student.new("Karry", "May", Date.new(1990, 1, 1))
    assert_equal initial_student_count + 1, Student.students.size
  end

  def test_add_duplicate_student
    initial_student_count = Student.students.size
    duplicate_student = Student.new("Jeanna", "Evalyn", Date.new(1999, 1, 1))
    assert_equal initial_student_count, Student.students.size
  end

  def test_remove_student
    initial_student_count = Student.students.size
    Student.remove_student("Smith", "Yuriy", Date.new(2005, 9, 15))
    assert_equal initial_student_count - 1, Student.students.size
  end

  def test_get_students_by_age
    students = Student.get_students_by_age(24)
    assert_includes students, @student1
  end

  def test_get_students_by_name
    students = Student.get_students_by_name("Carolina")
    assert_includes students, @student1
  end

  def test_birthdate_in_future
    assert_raises(ArgumentError) do
      Student.new("Future", "Person", Date.today + 1)
    end
  end
end
