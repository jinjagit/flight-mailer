class PassengerMailer < ApplicationMailer

  def booking_email
    @name = params[:name]
    @email = params[:email]
    @url  = 'http://example.com/login'
    mail(to: @email, subject: 'Booking confrimed!')
  end
end
