class BookingsController < ApplicationController

  def index
    !params[:bookings].blank? ? @bookings = Booking.where(id: params[:bookings]).all : @bookings = Booking.all.order(id: :desc)
  end

  def new
    if params.has_key?(:flight_select) == false
      flash[:error_select] = true
      redirect_to flights_path(session[:saved_search])
    else
      @passenger_count = params[:passenger_count].to_i
      @date = verbose_date(params[:flight_date])
      @booking = Booking.new(flight: Flight.find_by(id: params[:flight_select][:flight_id]), date: params[:flight_date])
    end
  end

  def create
    @passenger_count = params[:booking][:passenger_count].to_i
    @new_bookings = []

    @passenger_count.times do |i|
      @name = params[:passengers][:"name#{i + 1}"]
      @email = params[:passengers][:"email#{i + 1}"]
      @booking = Booking.new(
        flight_id: params[:booking][:flight_id],
        date: params[:booking][:date],
        passenger_attributes: {name:  @name, email: @email})
      @booking.save
      PassengerMailer.with(name: @name, email: @email, booking: @booking).booking_email.deliver_later
      @new_bookings << @booking
    end
    flash[:notice] = "Booking successful!"
    redirect_to controller: 'bookings', action: 'index', bookings: @new_bookings
  end
end
