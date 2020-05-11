my_rec = File.open('text_file.txt').each do |line|
  puts line
end

# File.extname("text_file.txt") { |x| puts x }
puts File.foreach('text_file.txt').count

