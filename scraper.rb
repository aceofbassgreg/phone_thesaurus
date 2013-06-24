class Scraper

  require 'rubygems'
  require 'capybara'

  def initialize
    @s = WordScraper::Capybara::Session.new :selenium
  end

  def session
    @s
  end

  def visit_site
    session.visit 'http://www.merriam-webster.com/browse/dictionary/a/a.htm'
  end

  def screenshot            # troubleshooting helper from when I was using headless browser.
    session.driver.render('./file.png', :full => true)
  end

  def scrape_words
    puts "foo"
    sleep 3
    session.click_link 'Skip This Ad' if session.has_link? 'Skip This Ad'
    session.within session.all(:css, '.pagination')[0] { session.has_link? 'Next' }
    session.click_link 'Skip This Ad' if session.has_link? 'Skip This Ad'
    sleep 3
    too_many_words = session.all(:xpath, "//ol['@class=entries']").collect {|word| word.text}
    words = too_many_words[4].split
    words.delete_if {|word| word.length > 7 }
    words.map! {|word| word.gsub(/[.,\ '&`~"$!?-]/,'')}
    File.open("dictionary.rb","a") {|f| f.puts(words)}
    puts "***************"
    session.within session.all(:css, '.pagination')[0] { session.click_link 'Next' }
    sleep 3
    puts "bar"
  end

  def repeat
    1000.times do
      scrape_words
    end
  end



  def read_file                                                 #learning about File class and IO
    File.open('dictionary.rb', 'r') do |x|
      while line = x.gets
        puts line[0]
      end
    end
    File.open('phone_numbers.rb', 'r') do |n|
      while line = n.gets
        puts line
      end
    end
  end
end