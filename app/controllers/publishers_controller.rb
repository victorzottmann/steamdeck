class PublishersController < ApplicationController
  def index
    @publishers = Publisher.all
  end

  def show
  end

  def new
    @publisher = Publisher.new
  end

  def edit
  end

  def create
    @publisher = Publisher.new(publisher_params)

    respond_to do |format|
      if @publisher.save
        format.html { redirect_to @publisher, notice: "Publisher was successfully created." }
        format.json { render :show, status: :created, location: @publisher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @publisher.update(publisher_params)
    redirect_to @publisher
  end
 
  def destroy
    @publisher.destroy
    redirect_to publishers_path
  end

  def search
    if params[:name].blank?
      redirect_to request.referrer
    else
      @name = params[:name].downcase
      @publishers = Publisher.where("lower(title) LIKE ?", "%#{@name}%")
    end
  end

  private

    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    def publisher_params
      params.require(:publisher).permit(:name)
    end
end
