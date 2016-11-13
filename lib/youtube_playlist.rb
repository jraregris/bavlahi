require 'yt'

# Seq for Youtube Playlists
class YoutubePlaylist
  @has_next = nil

  def videos
    options = { url: "https://www.youtube.com/playlist?list=#{@list}" }
    playlist = Yt::Playlist.new options
    list = playlist.playlist_items

    items = []

    list.each do |v|
      items << v
    end

    items.map do |i|
      i.snippet.data['resourceId']['videoId']
    end
  end

  def the_one_after_this_one(video_id, previous_video = nil)
    upto = videos.drop_while { |i| i != video_id }

    upto.shift
    if !upto.empty?
      @has_next = true
      return upto.first
    else
      @has_next = false
      return previous_video
    end
  end

  attr_accessor :current_video, :title, :list

  def next?
    next_id unless @has_next
    @has_next
  end

  def update(youtube_playlist)
    @current_video = youtube_playlist.current_video
    @title = youtube_playlist.title
    @list = youtube_playlist.list
  end

  def current_page
    make_embed_url(current_video)
  end

  def make_embed_url(video_id)
    "http://youtube.com/embed/#{video_id}"
  end

  def advance
    @current_video = next_id
  end

  def next_id
    STDOUT << "Checking YT playlist -> #{title}"
    lol = the_one_after_this_one(@current_video, @current_video)
    STDOUT << "#{@has_next ? ' new!' : '...'}\n"
    lol
  end

  def slug
    @title
      .gsub(' ', '-')
      .downcase
  end
end
