@students = [] # an empty array available to all methods

def append_students(name, cohort = :november)
  @students << {name: name, cohort: cohort}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    append_students(name)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts(csv_line)
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    append_students(name, cohort)
  end
  file.close
end

def default_load
  if File.exists?("students.csv")
    load_students
    puts "Loaded #{@students.count} from students.csv"
  else
    puts "Nothing to load"
  end
end

def load_process(filename)
  if filename.nil?
    default_load
  elsif File.exists?(filename)
    load_student(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def try_load_students
  filename = ARGV.first
  load_process(filename)
end

@methods_list = {
    "1" => method(:input_students),
    "2" => method(:show_students),
    "3" => method(:save_students),
    "4" => method(:load_students),
    "9" => method(:exit)
}

def process_input(selection)
  if selection =~ /[1-4]|9/ && selection.to_i < 10
    @methods_list[selection].call
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process_input(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu