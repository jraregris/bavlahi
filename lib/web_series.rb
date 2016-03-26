require 'open-uri'
require 'yaml'
require 'pry'

# Seq for html-pages with 'next' links
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
    STDOUT << "Checking web_series #{@title}\n"
    open(page, read_timeout: 10).read
  end

  def next_page
    html = read(current_page)
    match = next_pattern.match(html)

    return current_page unless match

    full_uri(match).to_s
  end

  def full_uri(match)
    path = match[1]

    return path if path =~ URI.regexp

    uri = URI(current_page)

    if path.start_with? '?'
      uri.query = path.strip
    else
      uri.path = "/#{path.split('?')[0]}"
      uri.query = path.split('?')[1]
    end

    uri
  end

  def next?
    @has_next ||= current_page != next_page
  end

  def advance!
    @current_page = next_page
  end
end
