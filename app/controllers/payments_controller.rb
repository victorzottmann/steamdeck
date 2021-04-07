class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
  end

  
  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    
    book = Book.find(payment.metadata.book_id)
    buyer = User.find(payment.metadata.user_id)

    rental = Rental.create(user_id: buyer.id, book_id: book.id)
    rental.save!
    
    book.quantity -= 1
    if book.quantity <= 0
      book.available = false
    end
    book.save!

    status 200
  end
end