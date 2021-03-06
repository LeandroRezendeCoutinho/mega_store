class Product < ApplicationRecord
  belongs_to :store

  SERVICE_TAX_PERCENTAGE = 0.20

  def buy(customer, amount)
    final_stock = stock - amount.to_i

    if final_stock >= 0
      ApplicationRecord.transaction do
        update!(stock: final_stock)

        purchase = Purchase.create!(
          product: self,
          amount: amount,
          store: store,
          customer: customer
        )

        Shipping.create!(
          address: customer.address,
          status: :waiting_clearance,
          purchase: purchase
        )

        purchase
      end
    else
      false
    end
  end

  def price
    base_price + service_tax
  end

  def service_tax
    base_price * SERVICE_TAX_PERCENTAGE
  end
end
