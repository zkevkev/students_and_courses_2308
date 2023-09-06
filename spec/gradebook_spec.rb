require 'rspec'
require './lib/course'
require './lib/student'
require './lib/gradebook'

RSpec.describe Gradebook do
  before(:each) do
    @gradebook = Gradebook.new("Marie Curie")
    @course_1 = Course.new("Calculus", 2)
    @course_2 = Course.new("Chemistry", 3)
    @student1 = Student.new({name: "Morgan", age: 21})
    @student2 = Student.new({name: "Jordan", age: 29}) 
  end
  
  it 'exists' do
    expect(@gradebook).to be_instance_of(Gradebook)
  end

  it 'has an instructor' do
    expect(@gradebook.instructor).to eq("Marie Curie")
  end

  it 'has no courses by default' do 
    expect(@gradebook.courses).to eq([])
  end

  describe '#add_course' do
    it 'adds a course to gradebook' do
      expect(@gradebook.courses).to eq([])

      @gradebook.add_course(@course_1)

      expect(@gradebook.courses).to eq([@course_1])
    end
  end

  describe '#list_all_students' do
    it 'returns a hash of courses and their students' do
      @course_1.enroll(@student1)
      @course_1.enroll(@student2)
      @course_2.enroll(@student1)
      @course_2.enroll(@student2)
      @gradebook.add_course(@course_1)
      @gradebook.add_course(@course_2)

      expect(@gradebook.list_all_students).to be_a(Hash)
      expect(@gradebook.list_all_students[@course_1]).to eq([@student1, @student2])
      expect(@gradebook.list_all_students[@course_2]).to eq([@student1, @student2])
    end
  end

  describe '#students_below' do
    it 'returns an array of students below the given grading threshold' do
      @gradebook.add_course(@course_1)
      @gradebook.add_course(@course_2)
      @course_1.enroll(@student1)
      @course_1.enroll(@student2)
      @course_2.enroll(@student1)
      @course_2.enroll(@student2)
      @student1.log_score(89)
      @student1.log_score(78)
      @student2.log_score(99)
      @student2.log_score(92)

      expect(@gradebook.students_below(100.0)).to eq([@student1, @student2])
      expect(@gradebook.students_below(90.0)).to eq([@student1])
      expect(@gradebook.students_below(75.0)).to eq([])
    end
  end
end