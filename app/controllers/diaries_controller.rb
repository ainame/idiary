require 'pp'
class DiariesController < ApplicationController
  def self.rixi
    scope = { 
      :r_profile => true,
      :w_profile => true,
      :r_profile_status => true,
      :r_profile_gender => true,
      :r_profile_birthday => true,
      :r_profile_blood_type => true,
      :r_profile_location => true,
      :r_profile_hometown => true,
      :r_profile_about_me => true,
      :r_profile_occupation => true,
      :r_profile_interests => true,
      :r_profile_favorite_things => true,
      :r_profile_organizations => true,
      :r_voice => true,
      :w_voice => true,
      :w_share => true,
      :r_photo => true,
      :w_photo  => true,
      :r_message => true,
      :w_message => true,
      :w_diary => true,
      :r_checkin => true,
      :w_checkin => true, 
      :r_updates => true
    }
    
    return @@mixi ||= Rixi.new(
                               :consumer_key => "8a8a598385989ae796ec",
                               :consumer_secret => "6bb150b0961620ea015d01d7020367e959008e7f",
                               :redirect_uri => 'http://0.0.0.0:3000/callback',
                               :scope => scope
                              ).get_token
  end

  def login
    redirect_to DiariesController.rixi.authorized_uri
  end

  def callback
    session[:login] = true
    mixi = DiariesController.rixi.get_token(params[:code])
    response = mixi.people "@me", "@self"
    session[:screen_name]  = response["entry"]["diplayName"]
    session[:uid]          = response["entry"]["id"]    
    session[:thumbnailUrl] = response["entry"]["thumbnailUrl"]    
    session[:access_token] = mixi.token.token
    session[:refresh_token] = mixi.token.refreash_token
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to root_path
  end

  # GET /diaries
  # GET /diaries.xml
  def index
    if session[:login]
      pp DiariesController.rixi 
      @photos = DiariesController.rixi.photos_in_album "@me", "@default"    
      pp @photos
    end
    # @diaries = Diary.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @diaries }
    end
  end

  # GET /diaries/1
  # GET /diaries/1.xml
  def show
    @diary = Diary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diary }
    end
  end

  # GET /diaries/new
  # GET /diaries/new.xml
  def new
    @diary = Diary.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diary }
    end
  end

  # GET /diaries/1/edit
  def edit
    @diary = Diary.find(params[:id])
  end

  # POST /diaries
  # POST /diaries.xml
  def create
    @diary = Diary.new(params[:diary])

    respond_to do |format|
      if @diary.save
        format.html { redirect_to(@diary, :notice => 'Diary was successfully created.') }
        format.xml  { render :xml => @diary, :status => :created, :location => @diary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @diary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /diaries/1
  # PUT /diaries/1.xml
  def update
    @diary = Diary.find(params[:id])

    respond_to do |format|
      if @diary.update_attributes(params[:diary])
        format.html { redirect_to(@diary, :notice => 'Diary was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @diary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1
  # DELETE /diaries/1.xml
  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy

    respond_to do |format|
      format.html { redirect_to(diaries_url) }
      format.xml  { head :ok }
    end
  end
end
