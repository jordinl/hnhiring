class HomeController < ApplicationController

  def show
    @month = Month.last
    expires_in 5.minutes, public: true
  end

end
