module Converter

  def phone_numbers
    ARGV
  end

  def dictionary
    ARGV || tidy_dictionary.rb
  end

  def read_convert_and_translate_number                                             
    File.open('phone_numbers.rb', 'r') do |x|
      while line = x.gets
        conversion_hash.each do |k,v|
          puts line.gsub( k, v )
        end
      end
    end
  end

  def parse(phone_number)
    if phone_number.include?(0) || phone_number.include?(1)    
  end
end


  def self.conversion_hash
    { '1' => ("1"), 
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
    end
  end