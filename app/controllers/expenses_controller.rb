class ExpensesController < ApplicationController
  def new
    @nav_titles = ["Add an expense", "Settle an expense"]
    @tabs = ["Add", "Settle"]
    @expense = Expense.new
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
  end

  def settle
    @expense = Expense.new
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @to_pay = User.find(params[:to_pay_id])
  end

  def create
    @nav_titles = ["Add an expense", "Settle an expense"]
    @tabs = ["Add", "Settle"]
    @user = User.find(getparams[:user_id])
    @group = Group.find(getparams[:group_id])
    @title = getparams[:title]
    # @to_pay = User.find(getparams[:to_pay_id])
    @amount_cents = getparams[:amount_cents].to_f * 100
    @description = getparams[:description]
    @payment_method = payment_type
    p getparams[:involved_group]
    p getparams[:settle_group]
    @involved_group_string = get_involved_group(getparams[:involved_group], getparams[:settle_group])
    @location = getparams[:location]
      @expense = Expense.new(
        title: @title,
        description: @description,
        amount_cents: @amount_cents,
        user_id: @user.id,
        group_id: @group.id,
        location: @location,
        payment_method: @payment_method)
    if @involved_group_string != "" && @involved_group_string != [@user.id.to_s] && @expense.save
      equal_splitter(@expense, @involved_group_string)
      redirect_to expense_path(@expense, user_id: @user.id, group_id: @group.id)
    else
      flash.now[:alert] = "You didn't select anyone"
      render :new
    end
  end

  def show
    @expense = Expense.find(params[:id].to_i)
    @user = User.find(params[:user_id])
    @group = get_group_id
    @nav_title = expense_show_nav_title(@expense)
  end

  private

  def expense_show_nav_title(expense)
    if expense.description == "Settled"
      return " #{expense.user.first_name} paid back #{expense.splits.first.user.first_name}"
    else
      return expense.title
    end
  end

  def equal_splitter(expense, involved_group_string)
    involved_group = involved_group_string.split(",")
    p involved_group_string
    number_involved = involved_group.length
    p number_involved
    an_equal_split = expense.amount_cents.to_i / number_involved
    involved_group.each do |member_id|
      if member_id.to_i == expense.user.id
        next
      end
      split = Split.new(expense_id: expense.id, user_id: member_id, amount_cents: an_equal_split)
      split.save!
    end
  end

  def get_involved_group(params_involved_group, params_settle_group)
    new_group = params_involved_group
    settle_group = params_settle_group
    if new_group.nil?
      puts settle_group
      return settle_group
    else
      puts new_group
      return new_group
    end
  end

  def get_group_id
    if params[:group_id]
      return Group.find(params[:group_id])
    else
      return "no_group"
    end
  end

  def payment_type
    if getparams[:payment_method] = "" || getparams[:payment_method].nil?
      return "card"
    else
      return getparams[:payment_method].downcase
    end
  end

  def getparams
    params.require(:expense).permit(:id, :split_type, :location, :settle, :title, :amount_cents, :description, :user_id, :group_id, :involved_group, :settle_group, :to_pay_id, :payment_method)
  end

end
