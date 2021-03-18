class HomeController < ApplicationController
  def index
    @books = Book.all

    @books.each do |book|
      if user_signed_in?
        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          customer_email: current_user.email,
          line_items: [{
            name: book.title,
            amount: (book.price * 100),
            currency: 'aud',
            quantity: 1
          }],
          payment_intent_data: {
            metadata: {
              user_id: current_user.id,
              book_id: book.id
            }
          },
          success_url: "#{root_url}payments/success",
          cancel_url: "#{root_url}"
        )
        @session_id = session.id
      end
    end
  end
end
