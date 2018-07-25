class Product < ApplicationRecord
  belongs_to :store

  PROFIT_PERCENTAGE = 0.20

  def buy(customer, amount)
    final_stock = stock - amount

    if final_stock >= 0
      update(stock: final_stock)

      Shipping.create(
        address: customer.address,
        status: 'pending'
      )

      Purchase.create(
        product: self,
        amount: amount,
        store: store,
        customer: customer,
        shipping: shipping
      )
    else
      false
    end
  end
end