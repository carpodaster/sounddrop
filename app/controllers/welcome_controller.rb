class WelcomeController < ApplicationController

  def index
    @drops = Drop.none
  end

  def about

  end
end
