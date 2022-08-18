c = File.read('and.edif')

c.gsub!(/\(rename (id[0-9]+) "[^"]+"\)/) do |x|
  p x[/id[0-9]+/]
end

File.write('a.edif', c)
