dictionary = File.open("5desk.txt")
lines = dictionary.read.split
word = lines.select {|line| line.length > 5 && line.length < 12}.sample