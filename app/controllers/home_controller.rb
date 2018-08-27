class HomeController < ApplicationController
  def show
    @month = Month.eager_load(:comments).order('comments.published_at ASC').last
  end
end
