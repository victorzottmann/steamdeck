class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  before_action :authenticate_user!

  def success
  end

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    book_id = payment.metadata.book_id
    user_id = payment.metadata.user_id

    status 200
    book = Book.find(book_id.to_i)
    book.quantity -= 1
    if book.quantity == 0
      book.available = false
    end
    book.save
  end
end