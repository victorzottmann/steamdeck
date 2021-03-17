class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def index
    @books = Book.all
  end

 
  def show
    @book = Book.find(params[:id])
    @user = current_user
  end

 
  def new
    @book = Book.new
    @book.build_author
    @book.build_publisher
    
    load_categories
  end

  
  def edit
    load_categories
  end

 
  def create
    @book = Book.new(book_params)
    @book.user = current_user
    load_categories
    if @book.save
      flash[:success] = "A new book was successfully created."
      redirect_to book_path(@book.id)
    else
      flash.now[:error] = @book.errors.full_messages.to_sentence
      render "new"
    end    
  end

  def update
    if @book.update(book_params)
      flash[:success] = "Book updated."
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
  end
 
  def destroy
    @book.destroy
    redirect_to books_path
  end

  def search 
    if params[:q].blank?
      redirect_to request.referrer
    else
      @title = params[:q].downcase
      @books = Book.where("lower(title) LIKE ?", "%#{@title}%")
    end
  end

  private
    
    def set_book
      @book = Book.find(params[:id])
    end

    def load_categories
      @categories = Category.all
    end

    def book_params
      params.require(:book).permit(:picture, :title, :edition, :pages, :date, :format, :price, :quantity, :author_id, :publisher_id, :category_id, author_attributes: [:name], publisher_attributes: [:name])
    end
end