class UsersController < ApplicationController 

    def index
        # check if params has user key
        # if so, use .where with "%#{params[:user]}%"
        if params.has_key?(:user)
            users = User.where("username LIKE '%#{params[:user]}%'")
        else
            users = User.all
        end
        render json: users
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end 
    end

    def show
        user = User.find(params[:id])
        render json: user 
    end

    def update
        @user = User.find(params[:id])
        user = @user.update(user_params)
        if user
            redirect_to user_url(@user.id)
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end 
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        render json: @user
    end

    private

    def user_params
        params.require(:user).permit(:username)
    end

end