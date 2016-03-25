require 'open-uri'
require 'yaml'
require 'pry'

class WebSeries
  attr_reader :next_pattern, :title
  attr_accessor :current_page, :has_next

  def initialize(title, next_pattern, current_page)
    @title = title
    @next_pattern = next_pattern
    @current_page = current_page
  end

  def merge(series)
    @title = series.title
    @next_pattern = series.next_pattern
    @current_page = series.current_page
  end

  def read(page)
    open(page, :read_timeout => 10).read
  end

  def next_page
    STDOUT << "Checking web_series #{@title}\n"
    html = read(current_page)
    match = next_pattern.match(html)
    return current_page if match.nil?
    path = match[1]
    if path =~ URI::regexp
      path
    elsif path.start_with? "?"
      uri = URI(current_page)
      uri.query = path.strip
      uri.to_s
    else
      uri = URI(current_page)
      uri.path = "/#{path.split('?')[0]}"
      uri.query = path.split('?')[1]
      uri.to_s
    end
  end

  def has_next?
    if !@has_next
      @has_next = current_page != next_page
    end
    @has_next
  end

  def advance!
    @current_page = next_page
  end
end
