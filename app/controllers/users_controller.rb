class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @group = get_group_id
    @users = User.all
    @tabs = ["Groups", "Transactions", "People"]
    @expenses_paid = Expense.where(user_id: @user.id)
    @splits_owed = Split.where(user_id: @user.id)
    @users_user_owed_by = users_user_owed_by(@user, @users)
    @users_user_owes = users_user_owes(@user, @users)
    @transactions = all_user_transactions(@user)
  end

  private

  def get_group_id
    if params[:group_id]
      return Group.find(params[:group_id])
    else
      return "no_group"
    end
  end

  def users_user_owed_by(current_user, users)
    users_owed = []
    users.each do |user|
      if current_user.outstanding_with_person_overall(user) > 0
        users_owed << user
      end
    end
    return users_owed
  end

  def users_user_owes(current_user, users)
    users_owes = []
    users.each do |user|
      if current_user.outstanding_with_person_overall(user) < 0
        users_owes << user
      end
    end
    return users_owes
  end

  def all_user_transactions(user)
    transactions = []
    expenses_paid = Expense.where(user_id: user.id)
    splits_owed = Split.where(user_id: user.id)

    expenses_paid.each do |expense|
      transactions << expense
    end
    splits_owed.each do |split|
      transactions << split
    end
    return transactions
  end
end
