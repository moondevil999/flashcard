
d = Deck.find_or_create_by_name('English to Malay')
array =[]
temp_arr =[]

File.open("programming.txt", "r") do |file|
  file.each_line do |line|
    line.sub!(/(.*)\n/,"\\1")
    temp_arr << line
  end
end
temp_arr.each_slice(3) {|elem| array << elem}

array.each do |e|
  Card.create(question:e[0],answer:e[1],deck_id:d.id)
end
