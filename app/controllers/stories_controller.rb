require 'soundcloud'

class StoriesController < ApplicationController
  
  def index
  end

  def show
    if session[:count].nil?
      session[:count] = 0
    end
    @session_count = session[:count]

    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f') 
 
    @story = Story.find_by_sc_track(params[:sc_track])
    if @story != nil
      @story_at_sc = client.get("/tracks/#{params[:sc_track]}")
    end
    @session = { @story[:story_id] => session[:count] }
  end

  def upvote
    @story = Story.find(params[:id])
    session[:count] = 0
    if session[:liked_stories].nil?
      session[:liked_stories] = []
    end
    unless 
      session[:liked_stories].include?(@story.id)
      session[:count] += 1
    @create_votes = @story.votes.create
      session[:liked_stories] << @story.id
    end
    @count_votes = @story.votes.count
    render json: {count_votes: @count_votes, session_count: @session_count, user_session: session[:liked_stories].inspect}
  end

  def playlists
    @story = Story.find_by_sc_track(params[:sc_track])
    client = SoundCloud.new(:client_id => '69e93cf2209402f6f3137a6452cf498f')
    @playlist = client.get("/playlists/#{params[:playlist_id]}") 
    @current_track_id = params[:sc_track].to_i 
    @story_at_sc = @playlist.tracks.find do |track|
      track[:id] == params[:sc_track].to_i
    end
  end

  def charts
    # @categories = (Date.today-4.. Date.today).map do 
    #   |date| date.to_s
    # end
    
    @stories = Story.all
    @story_votes =  @stories.map do |s|
      votes = (Date.today-4.. Date.today).map do
       |date| s.votes.total_on(date).to_i
      end 
      # {votes: votes}
    end
    #render json: {stats: @story_votes}
    render json: { 
      # categories: @categories,
      categories: ["2015-01-01", "2015-01-02"], 
      # stats: @story_votes
      stats: [
      { id: "1",
        title: "Coffee machine", 
        votes: [ 3 , 6]
      },
      { id: "2",
        title: "Brewing Coffee", 
        votes: [ 1 , 2]
      }
      ]
    }
  end
end
