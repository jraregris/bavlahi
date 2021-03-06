require 'bundler'
Bundler.setup

require 'dotenv'
Dotenv.load

require 'sinatra'
require 'open-uri'
require 'slim'

require './lib/web_series'
require './lib/youtube_channel'
require './lib/youtube_playlist'
require './lib/loader'
require './lib/saver'

get '/' do
  @series = Loader.load_all
  slim :index
end

get '/style.css' do
  sass :style
end

get 'edit' do
  all_series = Loader.load_all

  <<-HTML
  <a href='#{url('/')}'>Bavlahi</a>
  <form>
    <textarea name='series'
              rows='60'
              cols='50'>
  #{YAML.dump(all_series)}
    </textarea>
    <button formaction='/edit/'
            formmethod='post'>
      Update
    </button>
  </form>
  HTML
end

get '/edit/:series' do
  all_series = Loader.load_all
  series = all_series.detect { |s| s.title.casecmp(params[:series]).zero? }

  haml :edit_series, locals: { series: series, data: YAML.dump(series) }
end

post '/edit/:series' do
  all_series = Loader.load_all
  series = all_series.detect { |s| s.title.casecmp(params[:series]).zero? }
  new_series = YAML.load(request['series'])
  series.update(new_series)

  Saver.save_all(all_series)

  redirect url("/edit/#{series.title.downcase}")
end

get '/:series' do
  all_series = Loader.load_all
  @series = all_series.detect { |s| s.title.casecmp(params[:series]).zero? }
  slim :page
end

post '/:series/next' do
  all_series = Loader.load_all
  series = all_series.detect { |s| s.title.casecmp(params[:series]).zero? }
  puts "?? now #{series.title} is #{series.current_page}"
  series.advance

  Saver.save_all(all_series)

  redirect url("/#{series.title.downcase}")
end
