class DestinationsController < ApplicationController

  def index
      @destinations = Destination.all
      render :index
  end

  def new
      @destination = Destination.new
      render :new
  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      redirect_to destinations_path
    else
      render :new
    end
  end

  def edit
    @destination = Destination.find(params[:id])
    render :edit
  end

  def show
    @destination = Destination.find(params[:id])
    render :show
  end

  def update
    @destination= Destination.find(params[:id])
    if @destination.update(destination_params)
      redirect_to destinations_path
    else
      render :edit
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy
    redirect_to destinations_path
  end

  private
  def destination_params
    params.require(:destination).permit(:country, :city, :spot)
  end

end
