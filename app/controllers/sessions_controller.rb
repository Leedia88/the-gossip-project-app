class SessionsController < ApplicationController

    def create
        puts session_params
        @user = User.find_by(email: session_params[:email])
        if @user && @user.authenticate(session_params[:password])
            log_in(@user)
            puts session[:user_id]
            remember(@user) if remember_user?
            puts cookies
            puts current_user
            flash[:success] = "Bienvenue sur ta session, #{@user.full_name.capitalize}!"
            redirect_to root_path
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render :new
        end
    end

    def destroy
        log_out(current_user)
        flash[:info] = "Session bien terminée!"
        redirect_to root_path
    end

    private

    def session_params
        params.require(:session).permit(:email, :password)
    end    

    def remember_user?
        params[:commit] == "Log in and Remember me" || params[:commit] == "Sign up and Remember me"
    end
end
