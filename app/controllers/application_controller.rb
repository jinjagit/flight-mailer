require 'date'

class ApplicationController < ActionController::Base

  def verbose_date(date_string)
    verbose = Date.parse(date_string).strftime("%A, %d %B, %Y")
  end
end
