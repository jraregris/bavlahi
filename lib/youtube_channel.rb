require 'open-uri'
require 'json'

require 'yt'

class YoutubeChannel
  @has_next = nil

  def the_one_after_this_one video_id, page=1, previous_video=nil
    channel = Yt::Channel.new url: "https://www.youtube.com/user/#{@user}"
    list = channel.videos

    prev = previous_video

    a = []

    list.each do |v|
      if v.id != video_id
        a << v
      else
        break
      end
    end

    @has_next = a.size > 1

    if a.last
      return a.last.id
    else
      return video_id
    end
  end

  attr_accessor :current_video, :title, :user

  def has_next?
    if !@has_next
      next_id
    end

    @has_next
  end

  def update(youtube)
    @current_video = youtube.current_video
    @title = youtube.title
    @user = youtube.user
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
    STDOUT << "Checking YT channel -> #{title}"
    lol = the_one_after_this_one(@current_video, 1, @current_video)
    STDOUT << "#{@has_next ? " new!" : "..."}\n"
    lol
  end
end

