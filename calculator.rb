arr = []
result = []
operators = ['$', '@', '-', '+']

# Put all numbers in integer format
ARGV.each_with_index do |n, i|
  unless operators.include?(n)
    ARGV[i] = n.to_i
  end
end

# Check format
ARGV.each_with_index do |n, i|
  if i == 0
    puts "error" unless n.is_a?(Integer)
  elsif i == ARGV.size - 1
    puts "error" unless n.is_a?(Integer)
  elsif operators.include?(n)
    puts "error" unless ARGV[i-1].is_a?(Integer)
  elsif n.is_a?(Integer)
    puts "error" unless operators.include?(ARGV[i-1])
  end
end

# Multiplication and division are done first
ARGV.each_with_index do |n, i|
# Multiplication
  if n == '$'
    x = arr.last * ARGV[i+1]
    arr.pop
    arr.push(x)
# Division
  elsif n == '@'
    x = arr.last / ARGV[i+1]
    arr.pop
    arr.push(x)
  elsif ARGV[i-1] == '$' || ARGV[i-1] == '@'
    next
  else
    arr.push(n)
  end
end

# Addition and subtraction are processed second
arr.each_with_index do |n, i|
  if n == '+'
    result.push(0)
  elsif n == '-'
    x = result.last - arr[i+1]
    result.pop
    result.push(x)
  elsif arr[i-1] == '-'
    result.push(0)
  else
    result.push(n)
  end
end

# Add up all elements in the result array
sum = 0
result.each do |i|
  sum += i
end

# Return the final calculation
puts sum
