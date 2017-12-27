class PagesController < ApplicationController
  # DEV STUFF
  def home
  end

  def components
    @tabs = ["Groups", "Transactions", "People"]
    @tabs_second = ["Add", "Settle"]
    @expense = Expense.new
    @group = Group.last
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

  def report_a_bug
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @nav_title = "Report an issue"
  end
end
