require 'open-uri'
require 'json'

require 'yt'

# Seq for Youtube Channel
class YoutubeChannel
  @has_next = nil

  def the_one_after_this_one(video_id)
    channel = Yt::Channel.new url: "https://www.youtube.com/user/#{@user}"
    list = channel.videos

    a = []

    list.each do |v|
      break if v.id == video_id
      a << v
    end

    @has_next = a.size > 1

    return a.last.id if a.last

    video_id
  end

  attr_accessor :current_video, :title, :user

  def next?
    next_id unless @has_next

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

  def make_embed_url(video_id)
    "http://youtube.com/embed/#{video_id}"
  end

  def advance
    @current_video = next_id
  end

  def next_id
    STDOUT << "Checking YT channel -> #{title}"
    lol = the_one_after_this_one(@current_video)
    STDOUT << "#{@has_next ? ' new!' : '...'}\n"
    lol
  end

  def slug
    @title
      .gsub(' ','-')
      .downcase
  end
end
