class PagesController < ApplicationController
  # DEV STUFF
  def home
  end

  def components
  end

  # PRODUCTION USED PAGES
  def redirect
  end

  def create_kitty
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])

    puts @user
    puts @group
  end

  def info
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
  end
end
