class PassengerMailer < ApplicationMailer

  def booking_email
    @name = params[:name]
    @email = params[:email]
    @booking = params[:booking]
    mail(to: @email, subject: 'Booking confirmed!')
  end
end
