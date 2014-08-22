class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new( permitted_params )
    if @game.save
      redirect_to games_path, flash: { success: "Saved successfully" }
    else
      flash.now[:error] = "Something went wrong.."
      render :new
    end
  end

  private

  def permitted_params
    params.require(:game).permit(:title, :players)
  end

end
