class GroupsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @user.first_sign_in = false
    @user.save
    @group = Group.find(params[:group_id])
    @group.kitty_created = true
    @group.save
    @user_owes_splits_to_group = Split.joins(:expense).where(user_id: @user.id).where(expenses: {group_id: @group.id})
    @user_owed_splits_by_group = Split.joins(:expense).where(expenses: {user_id: @user.id}).where(expenses: {group_id: @group.id})
    @user_outstanding_with_group = outstanding_with_group(@user_owes_splits_to_group, @user_owed_splits_by_group)
    @nav_title = determine_navbar_title(@user_outstanding_with_group)
    @params_controller = params["controller"]
    @params_action = params["action"]
  end

  def update
    @user = User.find(params[:group][:user_id])
    @group = Group.find(params[:group][:group_id])
    @group.name = params[:group][:name]
    @group.save
    redirect_to group_path(@group, user_id: @user.id, group_id: @group.id)
  end

  def reminder
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @nav_titles = ["Send Reminder"]
  end

  def destroy
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @group_to_delete = Group.find(params[:group_to_delete_id])
    @group_to_delete.destroy
    redirect_to user_path(@user)
  end

  private

  def outstanding_with_group(user_owes_splits, user_owed_splits)
    user_owes_total = 0
    user_owed_total = 0

    user_owed_splits.each do |split|
      user_owed_total += split.amount_cents
    end

    user_owes_splits.each do |split|
      user_owes_total += split.amount_cents
    end

    return user_owed_total - user_owes_total
  end

  def determine_navbar_title(user_outstanding_with_group)
    if user_outstanding_with_group.to_f == 0
      return "You're all square"
    elsif user_outstanding_with_group.to_f < 0
      return "You owe: £#{sprintf('%.2f', user_outstanding_with_group.to_f * -1 / 100)}"
    else
      "You are owed: £#{sprintf('%.2f', user_outstanding_with_group.to_f / 100)}"
    end
  end

end
