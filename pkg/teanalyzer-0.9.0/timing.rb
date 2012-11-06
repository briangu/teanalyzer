require 'rubygems'
require 'teanalyzer'

#triads = Triad.from_text(text)
#efforts = triads.map { |t| t.effort }

keys = Keyboard.keys
keys.each do |k1|
  keys.each do |k2|
    keys.each do |k3|
      c1 = k1.chars.first
      c2 = k2.chars.first
      c3 = k3.chars.first
      triad = Triad.new(c1, c2, c3)
      puts "(#{c1},#{c2},#{c3}): #{triad.path_effort}"
    end
  end
end
