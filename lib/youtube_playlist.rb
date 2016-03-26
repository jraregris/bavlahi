require 'yt'

class YoutubePlaylist
  @has_next = nil

  def the_one_after_this_one video_id, page=1, previous_video=nil
    channel = Yt::Playlist.new url: "https://www.youtube.com/playlist?list=#{@list}"
    list = channel.playlist_items

    items = []

    list.each do |v|
      items << v
    end

    ids = []

    items.each do |i|
      ids << i.snippet.data['resourceId']['videoId']
    end

  
    upto = ids.drop_while { |i| i  != video_id }

    upto.shift
    if(upto.size > 0)
      @has_next = true
      return upto.first
    else
      @has_next = false
      return previous_video
    end

  end

  attr_accessor :current_video, :title, :list

  def has_next?
    if !@has_next
      next_id
    end
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

  def make_embed_url video_id
    "http://youtube.com/embed/#{video_id}"
  end

  def advance!
    @current_video = next_id
  end

  def next_id
    STDOUT << "Checking YT playlist -> #{title}"
    lol = the_one_after_this_one(@current_video, 1, @current_video)
    STDOUT << "#{@has_next ? " new!" : "..."}\n"
    lol
  end
end
