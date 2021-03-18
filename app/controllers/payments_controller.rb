class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
  end

  def webhook
    puts "***********"
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    
    book = Book.find(payment.metadata.book_id)
    buyer = User.find(payment.metadata.user_id)

    rental = Rental.create(user_id: buyer.id, book_id: book.id)
    rental.save!

    status 200

    puts "*******Rental:"
    p rental
  end
end