class GroupsController < ApplicationController
  respond_to :json
  
	def index
		@groups = current_user.groups
	end
  
  def new
  end
  
  def show
    @group = Group.find(params[:id])
    @posts = @group.wall.posts
		
		console
  end
  
  def create
		
    
    @cats = params[:categories]
    
    @newGroup = Group.new
    @newGroup.title = params[:title]
    @newGroup.description = params[:description]
    @newGroup.admin_id = params[:user_id]
    @newGroup.imageSource = params[:imageSource]

    @cats.each do |cat| 
      @newGroup.tags << Tag.find(cat[:id])
    end
    
    if @newGroup.save
      @newGroup.users << @newGroup.admin
      @newGroup.wall = Wall.create()
      render :json => { :redirect_to => "/groups/" + @newGroup.id.to_s }
    else
      render :json => { :redirect_to => ''}
    end
  
  end
end
