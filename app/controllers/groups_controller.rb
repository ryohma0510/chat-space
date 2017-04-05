class GroupsController < ApplicationController
  def new
  end

  def create
    Group.create(group_params)
    redirect_to :root
  end

  private
  def group_params
    params.require(:chat_group).permit(:name)
  end
end
