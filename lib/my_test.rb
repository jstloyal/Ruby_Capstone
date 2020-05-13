class Student
  @count = 0

  def initialize(*args)
    @first_name = args[0]
    @last_name = args[1]
    @address = args[2]
    @y_o_b = args[3]
    @school = args[4]
    @school.add_student
    @count += 1
  end

  def show_info
    puts @first_name + ' ' + @last_name + ' ' + @address + ' ' + @y_o_b.to_s + ' ' + @school.name
  end

  def self.show_class_info
    puts "There are #{@count} students"
  end

  def self.count_of_students
    @count
  end
end

class School
  attr_accessor :count_of_students, :name, :city

  def initialize(*args)
    @name = args[0]
    @city = args[1]
    @count_of_students = 0
  end

  def add_student
    @count_of_students += 1
  end
end

school1 = School.new('New York School', 'New york')
school2 = School.new('Oxford School', 'London')
jim = Student.new('John', 'Black', 'New york street', 2000, school1)
student_me = Student.new('Handerson', 'Baker', 'paris', 2001, school2)
jim.show_info
student_me.show_info
Student.show_class_info

puts school1.count_of_students
puts school2.count_of_students
