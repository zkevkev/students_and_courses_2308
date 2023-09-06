require 'rspec'
require './lib/course'
require './lib/student'

RSpec.describe Course do
  before(:each) do
    course = Course.new("Calculus", 2)
    student1 = Student.new({name: "Morgan", age: 21})
    student2 = Student.new({name: "Jordan", age: 29}) 
  end

  it 'exists' do
    expect(course).to be_instance_of(Course)
  end

  it 'has a name' do
    expect(course.name).to eq("Calculus")
  end

  it 'has a capacity' do
    expect(course.capacity).to eq(2)
  end

  it 'has no students by default' do
    expect(course.students).to eq([])
  end

  describe '#full?' do
    it 'can determine if it is at capacity' do
      expect(course.full?).to be false
    end
  end
 
  describe '#enroll' do
    it 'adds a student to the course' do
      course.enroll(student1)   
      course.enroll(student2)

      expect(course.students).to eq([student1, student2])
      expect(course.full?).to be true
    end
  end
end
