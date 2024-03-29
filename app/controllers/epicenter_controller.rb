class EpicenterController < ApplicationController
  def feed

  	# Here we initialize the array that will 
  	# hold tweets from the current_user's 
  	# following list.
  	@tweets_for_feed = []

  	# We pull in all the tweets...
  	@tweets = Tweet.all

  	# Then we sort through the tweets
  	# to find the ones associated with
  	# users from the current_user's 
  	# following array.
  	@tweets.each do |tweet|
  		current_user.following.each do |f|
  			if tweet.user_id == f
  				@tweets_for_feed.push(tweet)
  				# And those tweets are pushed
  				# into the @following_tweets array
  				# we saw back in the view.
  			end
  		end
  	end

    @tweet = Tweet.new
    @tweet.message = params[:message]
    @tweet.user_id = params[:user_id]
    @tweet.save

    @users = User.all
    @followers = []

    @users.each do |user|
      if user.following.include? current_user.id
        @followers.push(user)
      end
    end

  end

  def show_user
  	@user = User.find(params[:user_id])
    @tweets = @user.tweets.order(created_at: :desc)

    @tweet = Tweet.new
    @tweet.message = params[:message]
    @tweet.user_id = params[:user_id]
    @tweet.save
  end

  def now_following
  	# This line is just for displaying purposes:
  	@user = User.find(params[:follow_id])

  	# Here is where some back-end
  	# work really happens:
  	current_user.following.push(params[:follow_id].to_i)
  	# What we're doing is added the user.id of
  	# the User you want to follow to your
  	# 'following' array attribute.
  	current_user.save
  	# Then we save it in our database.

  end

  def show_all_users
    @users = User.all
  end

  def show_followers
    @users = User.all
    @followers = []

    @users.each do |user|
      if user.following.include? current_user.id
        @followers.push(user)
      end
    end
  end
  
end
