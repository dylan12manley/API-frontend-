require 'rest-client'
require 'json'

class DestinationsController < ApplicationController

  def index
    response = RestClient.get('http://localhost:3001/destinations')
    @destinations = response.body
    @destinations = JSON.parse(@destinations)
    render :index
  end

  def show
    response = RestClient.get ("http://localhost:3001/destinations/#{params[:id]}")
    @destinations = response.body
    @destinations = JSON.parse(@destinations)
    review = RestClient.get ("http://localhost:3001/destinations/#{params[:destination_id]}/reviews")
    @reviews = review.body
    @reviews = JSON.parse(@reviews)
    render :show
  end

  def new
    response = RestClient.get('destinations/new')
    @destinations = response.body
    @destinations = JSON.parse(@destinations)
    render :new
  end

  def create
    response = RestClient.post('destinations/')
    @destinations = response.body
    @destinations = JSON.parse(@destinations)
    @destination = Destination.new(destination_params)
    if @destination.save
      redirect_to destinations_path
    else
      render :new
    end
  end

  def edit
    response = RestClient.get('destinations/:id/edit')
    @destinations = response.body
    @destinations = JSON.parse(@destinations)
    @destination = Destination.new(destination_params)
    @destination = Destination.find(params[:id])
    render :edit
  end


  def update
    response = RestClient.patch('destinations/:id')
    @destinations = response.body
    @destinations = JSON.parse(@destinations)
    @destination = Destination.new(destination_params)
    @destination= Destination.find(params[:id])
    if @destination.update(destination_params)
      redirect_to destinations_path
    else
      render :edit
    end
  end

  def destroy
    response = RestClient.delete('destinations/:')
    @destinations = response.body
    @destinations = JSON.parse(@destinations)
    @destination = Destination.new(destination_params)
    @destination = Destination.find(params[:id])
    @destination.destroy
    redirect_to destinations_path
  end

  private
  def destination_params
    params.require(:destination).permit(:country, :city, :spot)
  end

end
