class SessionsController < ApplicationController

    def create
        puts session_params
        puts session_params[:email]
        @user = User.find_by(email: session_params[:email])
        if @user && @user.authenticate(session_params[:password])
            session[:user_id] = @user.id
            puts session
            flash[:success] = "Bienvenue sur ta session, #{@user.full_name.capitalize}!"
            redirect_to root_path
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render :new
        end
    end

    def destroy
        session.delete(:user_id)
        flash[:info] = "Session bien terminée!"
        redirect_to root_path
    end

    private

    def session_params
        params.require(:session).permit(:email, :password)
    end

end
