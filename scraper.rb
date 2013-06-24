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
    session.visit 'http://dictionary.reference.com/list/'
  end

  def screenshot            # troubleshooting helper from when I was using headless browser.
    session.driver.render('./file.png', :full => true)
  end

  def scrape_words
    links = session.all(:css, ".result_link").collect {|link| link.text}
    last_link = links.last
    all_words = session.all(:css, ".result_link").collect {|link| link.text}
    links.each do |link|
      session.click_link link
      sleep 2
      words = session.all(:css, ".result_link").collect { |word| word.text }
      all_words << words
      session.evaluate_script('window.history.back()')
      if link == last_link
        session.click_link 'NEXT'
        links = session.all(:css, ".result_link").collect {|link| link.text}
        all_words.delete_if {|word| word.length > 7 } 
        File.open("dictionary.rb","a") {|f| f.puts(all_words)}
        redo
      end
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