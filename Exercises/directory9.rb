def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    while true do
      puts "What is #{name}'s cohort?"
      cohort = gets.chomp
      cohort = 'november' if cohort.empty?
      months = ['january', 'february', 'march', 'april', 'june', 'july',
                'august', 'september', 'november', 'december']
      break if months.include?(cohort)
      puts "Sorry, that is not an available cohort"
    end
    students << { name: name, cohort: cohort.to_sym }
    puts "Now we have #{students.count} students"
    puts "Enter another name"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  cohorts = students.map { |student| student[:cohort] }.uniq
  cohorts.each do |cohort|
    puts " #{cohort} ".center(30, '-')
    students.each do |student|
      puts student[:name].center(30) if student[:cohort] == cohort
    end
  end
end

def print_footer(names)
  if names.count > 1
    puts "Overall, we have #{names.count} great students"
  else 
    puts "Overall, we have 1 great student"
  end
end

students = input_students
print_header
print(students)
print_footer(students)
