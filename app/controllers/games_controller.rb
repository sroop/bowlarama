class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :fetch_game, only: [:show, :edit, :update, :destroy]

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
      redirect_to @game, alert: "Saved successfully"
    else
      flash.now[:error] = "Something went wrong.."
      render :new
    end
  end

  def show
  end

  def edit
    @game.users << current_user unless @game.users.include?(current_user)
  end

  def update
      if @game.update_attributes(permitted_params)
        redirect_to @game, alert: "Saved successfully"
      else
        flash.now[:error] = "Something wrong..."
        render :edit
      end
  end

  def destroy
    @game.destroy
    redirect_to root_path, alert: "Deleted!"
  end

  private

  def fetch_game
    @game = Game.find(params[:id])
  end

  def permitted_params
    params.require(:game).permit(:title, user_ids: [])
  end

end
