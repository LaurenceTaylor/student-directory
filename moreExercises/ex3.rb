# Store the students given in an array available to all methods
@students = []

####################################################################
## Load file on startup (user input/ students.csv by default)
####################################################################

# load_students method is in the 'Deal with user input' section

def default_load
  if File.exists?("students.csv")
    load_students
    puts "Loaded #{@students.count} from students.csv"
  else
    puts "Nothing to load."
  end
end

def try_load_students(filename = ARGV.first)
  if filename.nil?
    default_load
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

####################################################################
## Menu
####################################################################

def interactive_menu
  loop do
    print_menu
    process_input(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

####################################################################
## Deal with user input
####################################################################

# Define relevant methods

# 1. Input the students

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

# 2. Show the students

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
  puts "-------------"
end

def show_students
  print_header
  print_students_list
  print_footer
end

# 3. Save the list to students.csv

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts(csv_line)
  end
  file.close
end

# 4. Load the list from students.csv

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    append_students(name, cohort)
  end
  file.close
end

# Call relevant method based on user input

@methods_list = {
    "1" => method(:input_students),
    "2" => method(:show_students),
    "3" => method(:save_students),
    "4" => method(:load_students),
    "9" => method(:exit)
}

def process_input(selection)
  if selection =~ /[12349]/ && selection.size == 1
    @methods_list[selection].call
  else
    puts "I don't know what you meant, try again"
  end
end

####################################################################
## Run program
####################################################################

# Load file of students if given/ students.csv exists
try_load_students

# Run program
interactive_menu