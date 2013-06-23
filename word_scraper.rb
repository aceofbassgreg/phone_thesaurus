class WordRobot

  require 'rubygems'
  require 'capybara/dsl'

  def initialize
    @s = WordRobot::Capybara::Session.new :selenium
  end

  def session
    @s
  end

  def all_words
    []
  end

  def visit_site_and_scrape_words
    session.visit 'http://dictionary.reference.com/list/'
    session.scrape_all_words
  end

  def scrape_all_words
    links = session.all(:css, ".result_link").collect {|link| link.text}

    links.each do |link|
      session.click_link link
      words = session.all(:css, ".result_link").collect {|word| word.text}
      all_words << words
      session.evaluate_script('window.history.back()')
    end
  end
end