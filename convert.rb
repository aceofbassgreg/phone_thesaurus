#!/usr/bin/env ruby

File.open("#{ARGV[0]}", 'r') do |phone_numbers|
  dictionary = ARGV[1] || 'tidy_dictionary.rb'
  combinations = []
  conversion_hash =  { '1' => ("1"), 
                       '2' => ("A, B, C"), 
                       '3' => ("D, E, F"),
                       '4' => ("G, H, I"), 
                       '5' => ("J, K, L"),
                       '6' => ("M, N, O"),
                       '7' => ("P, Q, R, S"),
                       '8' => ("T, U, V"),
                       '9' => ("W, X, Y, Z"),
                       '-' => ("-"),
                       '/' => ("-"),
                       '.' => ("-") }
 
  while line = phone_numbers.gets
    line.chars.each do |number|
      if number == conversion_hash.keys.any?
        conversion_hash.each do |k, v|
          number.gsub!(k,v) if k = number
        end
      end
    end
    puts line                            
    # File.open("#{dictionary}", "r") do |word|
    #   while entry = word.gets
    #     puts entry[0]
    #   end
    # end
  end
end


