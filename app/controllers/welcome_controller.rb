class WelcomeController < ApplicationController

  def index
    @drops = [Drop.find(234882)] # welcome track
  end

  def about

  end
end
