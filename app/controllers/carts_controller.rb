class CartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  before_action :set_cart, only: %i[ show edit update destroy ]

  def index
    @carts = Cart.all
  end

  
  def show

    # if user_signed_in?
    #   session = Stripe::Checkout::Session.create(
    #     payment_method_types: ['card'],
    #     customer_email: current_user.email,
    #     line_items: [{
    #       name: line_item.book.title,
    #       amount: (@book.price * 100),
    #       currency: 'aud',
    #       quantity: 1
    #     }],
    #     payment_intent_data: {
    #       metadata: {
    #         user_id: current_user.id,
    #         book_id: @book.id
    #       }
    #     },
    #     success_url: "#{root_url}payments/success?bookId=#{@book.id}",
    #     cancel_url: "#{root_url}books"
    #   )
    #   @session_id = session.id
    # end
  end


  def new
    @cart = Cart.new
  end


  def edit
  end


  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
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
