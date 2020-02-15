# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render locals: { user_session: UserSession.new, message: nil }
  end

  def create
    if login(user_session.login, user_session.password, true)
      redirect_to admin_root_url, success: t('flashes.welcome', name: current_user.name)
    else
      render :new, locals: { user_session: user_session, message: t('flashes.wrong_credentials') }
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: t('flashes.logout')
  end

  private

  def user_session
    @user_session ||= UserSession.new params[:user_session].permit(:login, :password, :remember_me)
  end
end
