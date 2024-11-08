require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'date'
require_relative "../homework_1"

Minitest::Reporters.use! [
  Minitest::Reporters::HtmlReporter.new(
    reports_dir: 'test/result',
    output_filename: "SpecTests.html",
    clean: true,
    add_timestamp: true
  )
]

describe Student do

  before do
    Student.class_variable_set(:@@students, [])
  end

  let(:student) { Student.new("Issac", "Carolina", Date.new(2000, 3, 9)) }

  describe 'initialization' do
    it 'creates a student with valid details' do
      expect(student.surname).must_equal "Issac"
      expect(student.name).must_equal "Carolina"
      expect(student.date_of_birth).must_equal Date.new(2000, 3, 9)
    end

    it 'raises an error for future birth dates' do
      expect{Student.new("Sick", "Joe", Date.today + 1) }.must_raise ArgumentError
    end
  end

  describe 'age calculation' do
    it 'calculates age correctly' do
      student = Student.new("Ivanov", "Stas", Date.new(2005, 11, 5))
      expect(student.calculate_age).must_equal 19
    end
  end

  describe 'check element in array' do
    it 'students have student element' do
      student = Student.new("447", "545", Date.new(2021, 6, 11))
      _(Student.students).must_include student
    end
  end

  describe 'check duplicate in array' do    
    it 'does not add duplicate students' do
      student1 = Student.new("Jeanna", "Evalyn", Date.new(1999, 1, 1))
      student2 = Student.new("Jeanna", "Evalyn", Date.new(1999, 1, 1))
      expect(Student.students.size).must_equal 1 
    end
  end

  describe 'student removal' do
    before do
      @student1 = Student.new("Jeanna", "Evalyn", Date.new(1999, 1, 1))
      @student2 = Student.new("John", "Doe", Date.new(2000, 2, 2))
    end
    it 'removes a student correctly' do
      expect(Student.students.size).must_equal 2
      Student.remove_student("Jeanna", "Evalyn", Date.new(1999, 1, 1))
      expect(Student.students.size).must_equal 1
      # Видалений студент не в списку
      expect(Student.students).wont_include @student1
    end
 
    it 'does not remove a student if the student does not exist' do
      expect(Student.students.size).must_equal 2
      # Спроба видалити ноунейма
      Student.remove_student("Nonexistent", "Student", Date.new(2020, 1, 1))
      expect(Student.students.size).must_equal 2
    end
  end

  describe 'get students by value' do    
    before do
      student1 = Student.new("Sharom", "Warren", Date.new(2000, 3, 9))
      student2 = Student.new("Jack", "Brown", Date.new(1999, 1, 1))
      student3 = Student.new("Alma", "Marshal", Date.new(2000, 2, 2))
    end
    
    it 'students have student with selected age' do              
      students_with_age_24 = Student.get_students_by_age(24)
      expect(students_with_age_24.size).must_equal 2
    end 

    it 'students have student with selected name' do        
      students_with_name_Jack = Student.get_students_by_name("Brown")
      expect(students_with_name_Jack.size).must_equal 1
    end
  end
end 
