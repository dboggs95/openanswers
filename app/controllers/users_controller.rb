class UsersController < ApplicationController
    before_action :user_exists, only: [:show, :edit, :destroy]
    before_action :set_user, only: [:show, :edit, :update, :destroy, :locked]
    before_action :signed_in_user, only: [:new, :create, :edit, :update, :index, :show]
    before_action :admin_user, only: [:index, :destroy]
    before_action :correct_user, only: [:show, :edit]
    before_action :locked_user, only: [:show, :new, :edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "#{@user.name}  was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def locked
    
  end

  private
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
	    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :locked)
    end
    def signed_in_user
        if !signed_in?
            flash[:failure] = "You must sign in first."
            redirect_to '/signin'
        end
    end
    def admin_user
        redirect_to home_index_path unless current_user.admin
    end
    def correct_user
        @user = User.find(params[:id])
        redirect_to home_index_path unless (current_user.id == @user.id || current_user.admin)
    end
    def locked_user
      if signed_in?
      if current_user.locked
        redirect_to users_locked_path(:id => current_user.id)
      end
    end
    end
    def user_exists
        redirect_to home_index_path unless !User.where(id: params[:id]).empty?
    end
end
