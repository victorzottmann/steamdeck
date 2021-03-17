class CartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  before_action :set_cart, only: %i[ show edit update destroy ]

  def index
    @carts = Cart.all
  end

  
  def show
    @books = current_user.carts.last.books
    line_items = @books.map do |book|
      {
        name: book.title,
        amount: (book.price * 100),
        currency: 'aud',
        quantity: 1
      }
    end

    if user_signed_in?
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: line_items,
        # payment_intent_data: {
        #   metadata: {
        #     user_id: current_user.id,
        #     book_id: @book.id
        #   }
        # },
        success_url: "#{root_url}payments/success",
        cancel_url: "#{root_url}books"
      )
      @session_id = session.id
    end
  end


  def new
    @cart = Cart.new
  end


  def create
    @cart = Cart.new(cart_params)
    end
  end


  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path

    # respond_to do |format|
    #   format.html { redirect_to root_path, notice: "Cart was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private

    def set_cart
      @cart = Cart.find(params[:id])
      # @cart = Cart.where(user_id: current_user.id)
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end

    def invalid_cart
      logger.error "Attemp to access invalid cart #{params[:id]}"
      redirect_to root_path, notice: "That cart does not exist"
    end
end
