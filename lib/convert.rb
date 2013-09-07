#!/usr/bin/env ruby

File.open("#{ARGV[0]}", 'r') do |phone_numbers|
  dictionary = ARGV[1] || 'tidy_dictionary.rb'
  combinations = []
  conversion_hash =  { '1' => ["1"], 
                       '2' => ["A", "B", "C"], 
                       '3' => ["D", "E", "F"],
                       '4' => ["G", "H", "I"], 
                       '5' => ["J", "K", "L"],
                       '6' => ["M", "N", "O"],
                       '7' => ["P", "Q", "R", "S"],
                       '8' => ["T", "U", "V"],
                       '9' => ["W", "X", "Y", "Z"],
                       '-' => ["-"],
                       '/' => ["-"],
                       '.' => ["-"] 
                     }

  while line = phone_numbers.gets
    first_digit = line[0]
    second_digit = line[1]
    all_possible_letters = []
    # puts conversion_hash('1')  THIS LINE THROWS ERROR
    if conversion_hash.keys.include?(first_digit)
      first_letters_array = conversion_hash[first_digit]
      second_letters_array = conversion_hash[second_digit]
      File.open(dictionary,'r') do |dictionary_words|
        if first_letters_array.count < 1
          # puts "true"
          
          #does something...keps the number or character? this will be 1, -, /, or .
          # end
        else
          possible_matches = []
          dictionary_words.each do |word|
            if first_letters_array.include?(word[0]) and second_letters_array.include?(word[1])
              possible_matches << word
            end
          end
          puts possible_matches.count
          possible_matches.each do |possible_matches|
            #if statement for processing two-letter words, break of and search for five-letter words
            #if statement for eliminating three-or-more letter words based on next digit in #. keep processing...
          end
        end
      end
    else
      puts "Invalid phone number"
    end
  end
end


