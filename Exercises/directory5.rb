def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << { name: name }
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def add_student_info(students)
  puts "Now add the students' hobbies, country of birth, and height."
  students.each do |student|
    puts "What is #{student[:name]}'s cohort?"
    cohort = gets.chomp
    student[:cohort] = cohort
    puts "What are #{student[:name]}'s hobbies?"
    hobbies = gets.chomp
    student[:hobbies] = hobbies
    puts "What is #{student[:name]}'s height?"
    height = gets.chomp
    student[:height] = height
    puts "What is #{student[:name]}'s country of birth?"
    cob = gets.chomp
    student[:cob] = cob
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |student| 
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
    puts "#{student[:name]}'s hobbies: #{student[:hobbies]}"
    puts "#{student[:name]}'s height: #{student[:height]}"
    puts "#{student[:name]}'s country of birth: #{student[:cob]}"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = add_student_info(input_students)
print_header
print(students)
print_footer(students)
