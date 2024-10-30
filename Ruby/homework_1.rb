require 'date'
class Student
  @@students = []
  attr_reader :surname, :name, :date_of_birth

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    
    if date_of_birth < Date.today
      @date_of_birth = date_of_birth
    else
      raise ArgumentError.new("Birth date can't be in the future")
    end
    add_student
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth.next_year(age)
    age
  end

  def add_student
    return if @@students.any? { |student| student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth }
    @@students << self
  end

  def self.remove_student(surname, name, date_of_birth)
    @@students.delete_if { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.students
    @@students
  end
end


student1 = Student.new("Issac", "Carolina", Date.new(2000, 3, 9))
student2 = Student.new("Smith", "Yuriy", Date.new(2005, 9, 15))
student3 = Student.new("Jeanna", "Evalyn", Date.new(1999, 1, 1))
student4 = Student.new("Jeanna", "Evalyn", Date.new(1999, 1, 1)) # Дублікат
student5 = Student.new("Sick", "Jon", Date.new(2001, 7, 19))

puts "Students:"
Student.students.each {|student| puts "#{student.surname} #{student.name}, age: #{student.calculate_age}"}

puts "\nStudents aged 24:"
Student.get_students_by_age(24).each {|student| puts "#{student.surname} #{student.name}"}

puts "\nStudents named Jon:"
Student.get_students_by_name("Jon").each {|student| puts "#{student.surname} #{student.name}"}

Student.remove_student("Smith", "Yuriy", Date.new(2005, 9, 15))

puts "\nStudents after removing Yuriy Smith:"
Student.students.each {|student| puts "#{student.surname} #{student.name}, age: #{student.calculate_age}"}
