class UsersController < ApplicationController
  def search
    respond_to do |format|
      format.json { render json: User.where('name LIKE(?)',"%#{search_params[:keyword]}%").limit(20) }
    end
  end

  private

  def search_params
    params.permit(:keyword)
  end
end
