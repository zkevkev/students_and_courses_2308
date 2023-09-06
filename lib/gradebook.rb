class Gradebook
  attr_reader :instructor, :courses

  def initialize(instructor)
    @instructor = instructor
    @courses = []
  end

  def add_course(course)
    @courses << course
  end

  def list_all_students
    students_in_course = Hash.new

    @courses.each do |course|
      students_in_course[course] = course.students
    end
    students_in_course
  end

  def students_below(threshold)
    student_list = []
    
    @courses.each do |course|
      course.students.each do |student|
        if student.grade < threshold && !student_list.include?(student)
          student_list << student 
        end
      end
    end
    student_list
  end

  def all_grades
    grade_list = Hash.new

    @courses.each do |course|
      course_grades = []

      course.students.each do |student|
        course_grades.concat(student.scores)
      end
      grade_list[course] = course_grades
    end
    grade_list
  end

  def students_in_range(min, max)
    student_list = []

    @courses.each do |course|
      course.students.each do |student|
        if student.grade <= max && student.grade >= min && !student_list.include?(student)
          student_list << student 
        end
      end
    end
    student_list
  end
end