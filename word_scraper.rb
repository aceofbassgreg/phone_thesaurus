class WordScraper

  require 'rubygems'
  require 'capybara'
  require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app)
end

  def initialize
    @s = WordScraper::Capybara::Session.new :poltergeist
  end

  def session
    @s
  end

  def visit_site
    session.visit 'http://dictionary.reference.com/list/'
  end

  def screenshot            # troubleshooting helper :-)
    session.driver.render('./file.png', :full => true)
  end

  def scrape_words
    links = session.all(:css, ".result_link").collect {|link| link.text}
    all_words = []
    links.each do |link|
      session.click_link link if link
      sleep 2
      words = session.all(:css, ".result_link").collect { |word| word.text }
      all_words << words
      session.evaluate_script('window.history.back()')
      sleep 2
      if session.has_link? 'NEXT'
        session.click_link 'NEXT'
        session.all(:css, ".result_link").collect {|link| link.text}
        links = session.all(:css, ".result_link").collect {|link| link.text}
      end
      redo
    end

    all_words.delete_if {|word| word.length > 7 }
    all_words.map! {|word| word.gsub(/[.,\ '&`~"$!?]/, '')}    #removing symbols and spaces from words
    File.open("dictionary.txt","w") {|f| f.puts(all_words)}
  end

  def read_file 
    dictionary = File.new('dictionary.rb', 'r')
    dictionary.each do |word|
      puts word
    end
  end
end