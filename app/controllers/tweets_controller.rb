class TweetsController < ApplicationController
  # GET /tweets
  # GET /tweets.xml
  def index
    @title = "POIDH: pics or it didn't happen! (from twitter)"
    #@tweets = Tweet.find(:all, :order => 'observer_msg_timestamp DESC')
    @tweets = Tweet.paginate(:per_page => 20, :page => params[:page], :order => 'observer_msg_timestamp DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tweets }
    end
  end

  # GET /tweets/1
  # GET /tweets/1.xml
  def show
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tweet }
    end
  end

  # # GET /tweets/new
  # # GET /tweets/new.xml
  # def new
  #   @tweet = Tweet.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @tweet }
  #   end
  # end
  # 
  # # GET /tweets/1/edit
  # def edit
  #   @tweet = Tweet.find(params[:id])
  # end
  # 
  # # POST /tweets
  # # POST /tweets.xml
  # def create
  #   @tweet = Tweet.new(params[:tweet])
  # 
  #   respond_to do |format|
  #     if @tweet.save
  #       flash[:notice] = 'Tweet was successfully created.'
  #       format.html { redirect_to(@tweet) }
  #       format.xml  { render :xml => @tweet, :status => :created, :location => @tweet }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @tweet.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # PUT /tweets/1
  # # PUT /tweets/1.xml
  # def update
  #   @tweet = Tweet.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @tweet.update_attributes(params[:tweet])
  #       flash[:notice] = 'Tweet was successfully updated.'
  #       format.html { redirect_to(@tweet) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @tweet.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /tweets/1
  # # DELETE /tweets/1.xml
  # def destroy
  #   @tweet = Tweet.find(params[:id])
  #   @tweet.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(tweets_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
