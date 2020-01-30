require 'rest-client'
require 'json'

class DestinationsController < ApplicationController
  # include Destinations_fetcher

  def index
    response = RestClient.get('http://localhost:3001/destinations')
    @destinations = response.body
    @destinations = JSON.parse(@destinations)
    render :index
  end

  def show
    response = RestClient.get ("http://localhost:3001/destinations/#{params[:id]}")
    @destination = response.body
    @destination = JSON.parse(@destination)
    response= RestClient.get ("http://localhost:3001/destinations/#{params[:id]}/reviews")
    @reviews = response.body
    @reviews = JSON.parse(@reviews)
    render :show
  end

  def new
    render :new
  end

  def create
    RestClient.post "http://localhost:3001/destinations", {country: "#{params[:country]}", city: "#{params[:city]}", spot: "#{params[:spot]}"}
    redirect_to destinations_path
  end

  def edit
    render :edit
  end

  def update
    RestClient.patch "http://localhost:3001/destinations/#{params[:id]}", {country: "#{params[:country]}", city: "#{params[:city]}", spot: "#{params[:spot]}"}
    redirect_to destinations_path
  end

  def destroy
    RestClient.delete("http://localhost:3001/destinations/#{params[:id]}")
    redirect_to destinations_path
  end

  private
  def destination_params
    params.require(:destination).permit(:country, :city, :spot)
  end
end
