class WelcomeController < ApplicationController

  before_action :use_your_api_luke

  def index
    @drops = Drop.all
  end

  def about

  end
end
