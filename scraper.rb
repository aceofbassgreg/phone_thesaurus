class Scraper

  require 'rubygems'
  require 'capybara'

  def initialize
    @s = Scraper::Capybara::Session.new :selenium
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
    sleep 2
    session.click_link 'Skip This Ad' if session.has_link? 'Skip This Ad'
    session.within session.all(:css, '.pagination')[0] { session.has_link? 'Next' }
    session.click_link 'Skip This Ad' if session.has_link? 'Skip This Ad'
    sleep 2
    too_many_words = session.all(:xpath, "//ol['@class=entries']").collect {|word| word.text}
    words = too_many_words[4].split
    words.delete_if {|word| word.length > 7 }
    words.map! {|word| word.gsub(/[.,\ '&`~"$!?-]/,'')}
    File.open("dictionary.rb","a") {|f| f.puts(words)}
    sleep 2
    session.within session.all(:css, '.pagination')[0] { session.click_link 'Next' }
    sleep 2
    puts "still running!"
  end

  def repeat            # would've loved to have scrape_words end dynamically, but kept getting Selenium stale_content errors.
    1000.times do
      scrape_words
    end
  end

  def tidy_and_store
    arr = []
    File.open('dictionary.rb','r') do |x|
      while line = x.gets
        arr << line.upcase
      end
    end
    arr.uniq!.sort!
    File.open("tidy_dictionary.rb", "w") { |f| f.puts(arr) }
  end 
end