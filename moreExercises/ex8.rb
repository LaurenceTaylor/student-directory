File.open($0, "r") do |file|
  file.readlines.each { |line| puts line }
end