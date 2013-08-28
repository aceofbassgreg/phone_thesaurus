class Scraper

  require 'rubygems'
  require 'capybara'

  def initialize
    @session = Scraper::Capybara::Session.new :selenium
  end

  def session
    @session
  end

  def scrape_and_restart_if_crash            # would've loved to have scrape_words end dynamically, but kept getting Selenium stale_content errors.
    1000.times do
      scrape_words
    end
  end

  def scrape_words
    visit_site
    sleep 2
    skip_ad
    session.within session.all(:css, '.pagination')[0] { session.has_link? 'Next' }
    skip_ad
    sleep 2
    too_many_words = collect_words
    words = trim_and_clean_words(too_many_words)
    put_words_in_file(words)
    sleep 2
    click_next
    sleep 2
    puts "still running!"
  end

  def visit_site
    session.visit 'http://www.merriam-webster.com/browse/dictionary/a/a.htm'
  end

  def skip_ad
    session.click_link 'Skip This Ad' if session.has_link? 'Skip This Ad'
  end

  def collect_words
    session.all(:xpath, "//ol['@class=entries']").collect {|word| word.text}
  end

  def trim_and_clean_words(words)
    too_many_words[4].split
    words.delete_if {|word| word.length > 7 }             
    words.map! {|word| word.gsub(/[.,\ '&`~"$!?-]/,'')}
    return words  
  end

  def put_words_in_file(words)
    File.open("dictionary.rb","a") {|f| f.puts(words)
  end

  def click_next
    session.within session.all(:css, '.pagination')[0] { session.click_link 'Next' }
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