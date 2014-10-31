class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(permitted_params)
    if @game.save!
      redirect_to games_path, flash: { success: "Saved successfully" }
    else
      flash.now[:error] = "Something went wrong.."
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
      if @game.update_attributes(permitted_params)
        redirect_to [@game], flash: { success: t('flash.saved') }
      else
        flash.now[:error] = "Something wrong..."
        render :edit
      end
  end

  private

  def permitted_params
    params.require(:game).permit(:title, user_ids: [])
  end

end
