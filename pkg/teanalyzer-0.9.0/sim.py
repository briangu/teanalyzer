require 'rubygems'
require 'teanalyzer'
require 'tuple'

#triads = Triad.from_text(text)
#efforts = triads.map { |t| t.effort }

def encodeChar(ch)
  if ch == '"'
    "QUOTE"
  elsif ch == '\\'
    "BACKSLASH"
  else
    ch
  end
end

puts "{"
keys = Keyboard.keys
keys.each do |k1|
  keys.each do |k2|
    c1 = k1.chars.first
    c2 = k2.chars.first
    timing = Tuple.new(c1,c2).effort
    puts "\"#{encodeChar(c1)}#{encodeChar(c2)}\": #{timing},"
  end
end
puts "}"

def emulate(text)
  a = Tuple.from_text(text)
  firstChar = a[0].keys(lambda { |k| k.chars[0] })[0]
  a = a.unshift(Tuple.new(firstChar,firstChar))
  text.split("").each do |ch| 
    delay = 70
    if ch != ' '
      x = a.shift
      delay = x.effort * 250
    end
    delay = delay + rand * 10
    sleep(delay * 0.0001)
    puts ch 
  end
end

emulate("hello, how are you?")

file = File.new("aliceinwonderland.txt", "r")
emulate(file.read()) 
