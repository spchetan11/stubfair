class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
   #before_action :authenticate_user!, only: [:create,:update,:edit,:new]
   skip_before_filter :verify_authenticity_token

  # GET /users
  # GET /users.json
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def index
    @users = User.all
  end


  # GET /users/1
  # GET /users/1.json
  def show
    @user_id = User.find(params[:id])
    id = @user_id.id
    puts(id)
    @user = User.find(id)
    puts(@user)
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
    puts("before looop")
    respond_to do |format|
      if @user.save
        puts("inside looop")
        #below not working for some reason
        # id = @user.id
        # puts (id)
        # puts("new user created")
        # @band = Band.new
        # @band.update(:user_id => @user.id, :value => "0.05")
        format.html { redirect_to :show, notice: 'User was successfully created.' }
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
      if @user.update(user_edit_params)
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email,:password).except(:first_name, :last_name, :gender, :phone, :age, :address, :postcode, :buyer_band, :seller_band, :paypal_email)
    end

    def user_edit_params
      params.require(:user).permit(:first_name, :last_name, :gender, :phone, :age, :address, :postcode, :buyer_band, :seller_band, :paypal_email).except(:email, :password)
    end
    
end
