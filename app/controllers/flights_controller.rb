class FlightsController < ApplicationController

  def index
    unless params[:find_flights].nil?
      @flights_found = Flight.where(from_id: params[:find_flights][:from],
                                    to_id: params[:find_flights][:to]).all
      @passenger_count = params[:find_flights][:passenger_count]
      @date = params[:find_flights][:date]
      session[:saved_search] = params
      if @date.blank?
        flash.now[:error_no_date] = true
      end
      if params[:find_flights][:from] == params[:find_flights][:to]
        flash.now[:error_from_to] = true
      end
    end
  end

  def list
    @flights = Flight.all
  end
end
