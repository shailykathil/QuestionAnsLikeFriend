class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]

def friend
	if Friendship.where(sender: current_user.id,receiver: params[:id], accept: false).first.present?
	  flash[:notice] = "you have already sent the friend  request to this user"
	elsif Friendship.where(sender: current_user.id,receiver: params[:id], accept: true).first.present?
	  flash[:notice] = "You are already friend of this user"  
	else
	  Friendship.create(sender: current_user.id,receiver: params[:id], accept: false )
	  flash[:notice] = "friend request sent"  
	end  
	redirect_to user_path(id: current_user.id)
end
def accept_friend
	@abc=Friendship.where(receiver: params[:re] ,sender: params[:se]).first
	@abc.update(accept: true)
	flash[:notice] = "Now you are friend with #{User.where(id: params[:se]).first.email}"
	redirect_to user_path(id: current_user.id)
end
def delete_friend
	@abc=Friendship.where(receiver: params[:re] ,sender: params[:se]).first
	@abc.destroy
	flash[:notice] = "request deleted"
	redirect_to user_path(id: current_user.id)
end
# def notification
# 	@likenotifications= Notification.where(recipient_id: current_user.id,notifiable_for: "like")
# 	@dislikenotifications= Notification.where(recipient_id: current_user.id,notifiable_for: "dislike")  
# end
  # GET /users/:id.:format
def show
	if Friendship.where(receiver: current_user.id).first.present?
	  @friend_request = Friendship.where(receiver: current_user.id)
	end 
	 @users = User.all.where.not(id: current_user)
	if Friendship.where(receiver: current_user.id).first.present? || Friendship.where(sender: current_user.id).first.present?
	  @friends = Friendship.where(receiver: current_user.id)
	  @friends1 = Friendship.where(sender: current_user.id)
	  # @friendships = @friends+@friends1
	end
end
def edit
end
# PATCH/PUT /users/:id.:format
def update
# authorize! :update, @user
	respond_to do |format|
	  if @user.update(user_params)
	    sign_in(@user == current_user ? @user : current_user, :bypass => true)
	    format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
	    format.json { head :no_content }
	  else
	    format.html { render action: 'edit' }
	    format.json { render json: @user.errors, status: :unprocessable_entity }
	  end
	end
end
# DELETE /users/:id.:format
def destroy
# authorize! :delete, @user
	@user.destroy
	respond_to do |format|
	  format.html { redirect_to root_url }
	  format.json { head :no_content }
	end
end

private
	def set_user
	   @user = User.find(params[:id])
	end

	def user_params
	  accessible = [ :name, :email ] # extend with your own params
	  accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
	  params.require(:user).permit(accessible)
	end
end
