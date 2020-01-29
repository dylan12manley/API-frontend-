class ReviewsController < ApplicationController

  def index
      @reviews = Reivew.all
      render :index
  end

  def new
      @review = Reivew.new
      render :new
  end

  def create
    @review = Reivew.new(review_params)
    if @review.save
      redirect_to reviews_path
    else
      render :new
    end
  end

  def edit
    @review = Reivew.find(params[:id])
    render :edit
  end

  def show
    @review = Reivew.find(params[:id])
    render :show
  end

  def update
    @review= Reivew.find(params[:id])
    if @review.update(review_params)
      redirect_to reviews_path
    else
      render :edit
    end
  end

  def destroy
    @review = Reivew.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  private
  def review_params
    params.require(:review).permit(:body, :pi_rating, :destination_id)
  end

end
