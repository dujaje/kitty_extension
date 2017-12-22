class AddPaymentMethodToExpense < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :payment_method, :string, default: "card"
  end
end
