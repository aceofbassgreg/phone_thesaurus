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

  def scrape_and_store_all_words
    links = session.all(:css, ".result_link").collect {|link| link.text}
    all_words = []

    links.each do |link|
      session.click_link link
      words = session.all(:css, ".result_link").collect {|word| word.text}
      all_words << words
      visit_site
    end
    all_words.prune_and_upcase
    all_words.map! {|word| element.gsub!(/[.,\ '&`~"$!?]/, '')}    #removing symbols and spaces from words
    File.open("dictionary.txt","w") {|f| f.puts(all_words)}
  end

  def prune_and_upcase
    all_words.each do |word|
      if word.length > 7
        all_words.delete(word)
      else
        word.upcase
      end
    end
  end

end