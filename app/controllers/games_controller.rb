class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @game.users << current_user
  end

  def create
    @game = Game.new(permitted_params)
    if @game.save!
      redirect_to game_path(@game.id), flash: { success: "Saved successfully" }
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
    @game.users << current_user unless @game.users.include?(current_user)
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

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to root_path
  end

  private

  def permitted_params
    params.require(:game).permit(:title, user_ids: [])
  end

end
