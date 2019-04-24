require "csv"

# Store the students given in an array available to all methods
@students = []

####################################################################
## Load file on startup (user input/ students.csv by default)
####################################################################

# load_students method is #4 in the 'Deal with user input' section

def print_load_failure(filename)
  if filename == "students.csv"
    puts "Nothing to load."
  else
    puts "Sorry, #{filename} doesn't exist."
  end
end

def check_file_exists(filename = "students.csv")
  if File.exists?(filename)
    load_students(filename)
  else
    print_load_failure(filename)
  end
end

def try_load_students
  given_filename = ARGV.first
  given_filename.nil? ? check_file_exists : check_file_exists(given_filename)
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

# Method to append to @students array, used by 1. and 4.

def append_students(name, cohort = :november)
  @students << {name: name, cohort: cohort}
end

# 1. Input the students

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

def which_save_file?
  puts "Which file would you like to save to?"
  STDIN.gets.chomp
end

def save_students
  CSV.open(which_save_file?, "w") do |csv|
    @students.each { |student| csv << [student[:name], student[:cohort]] }
  end
end

# 4. Load the list from students.csv

def which_load_file?
  puts "Which file would you like to load from?"
  STDIN.gets.chomp
end

def load_students(filename = which_load_file?)
  CSV.foreach(filename) do |line|
    name, cohort = line
    append_students(name, cohort)
  end
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
    puts "Your selection [#{selection}] was successful."
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