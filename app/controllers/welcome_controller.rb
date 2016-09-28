class WelcomeController < ApplicationController

  def index
    @drops = [Drop.new({title: "ABSOLVENTA", longitude: 13.3900989, latitude: 52.5120181, sc_track: "dummy"})]
  end

  def about

  end
end
