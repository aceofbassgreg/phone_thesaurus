class Converter

  def read_file                                             
    File.open('dictionary.rb', 'r') do |x|
      while line = x.gets
        puts line[0]
      end
    end
  end
      
  def get_and_convert_numbers
    master_phone_number_array = []
    File.open('phone_numbers.rb', 'r') do |number|
      while line = number.gets
        string = line.to_s
        string[0..7].each do |digit|
          case digit
          when digit == 1
            digit = ["1"]
          when digit == 2
            digit = ["A", "B", "C"]
          when digit == 3
            digit = ["D", "E", "F"]
          when digit == 4
            digit = ["G", "H", "I"]
          when digit == 5
            digit = ["J", "K", "L"]
          when digit == 6
            digit = ["M", "N", "O"] 
          when digit == 7
            digit = ["P", "Q", "R", "S"]
          when digit == 8
            digit = ["T", "U", "V"]
          when digit == 9
            digit = ["W", "X", "Y", "Z"] 
          end
          master_phone_number_array << string[0..7]
          master_phone_number_array.each do |single_phone_number|  #trying to match each phone number with word combos
            single_phone_number[0].each do |first_character|
              single_phone_number[1].each do |second_character|
                single_phone_number[2].each do |third_character|
                  single_phone_number[4].each do |fourth_character|
                    single_phone_number[5].each do |fifth_character|
                      single_phone_number[6].each do |sixth_character|
                        single_phone_number[7].each do |seventh_character|
                          puts first_character + second_character + third_character
                            + fourth_character + fifth_character + sixth_character
                            + seventh_character
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end


