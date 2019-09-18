class ParsesController < ApplicationController

  def new ;end

  def create
    Log.new(params[:quake_log])
    redirect_to '/index'
  end

  def index
    @file = File.open(File.absolute_path("log/games.log"))
    @parsed = QuakeLogParseService.perform(@file)
  end
end
