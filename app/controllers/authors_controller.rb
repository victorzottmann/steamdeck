class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: "Author was successfully created." }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @author.update(author_params)
    redirect_to @author
  end
 
  def destroy
    @author.destroy
    redirect_to authors_path
  end

  def search
    if params[:q].blank?
      redirect_to request.referrer
    else
      @name = params[:q].downcase
      @authors = Author.where("lower(title) LIKE ?", "%#{@name}%")
    end
  end

  private

    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:name)
    end
end
