class GroupsController < ApplicationController
before_action :user_belongs_to_group?, only: :show

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    if group.name.present? && group_params[:users_groups_attributes].length != 1
      group.save
      redirect_to group_path(group.id)
    else
      redirect_to new_group_path
    end
  end

  def show
    @groups = current_user.groups
    @group = Group.find(params[:id])
    @users = @group.users
  end

  private

  def group_params
    selected_params = params.require(:group).permit(:name, user_ids:[])
    users_groups_array = []
    selected_params[:user_ids].each do |id|
      users_groups_array << { user_id: id }
    end
    return { name: "#{ selected_params[:name] }", users_groups_attributes: users_groups_array }
  end

  def user_belongs_to_group?
    redirect_to :root unless current_user.groups.ids.include?(params[:id].to_i)
  end
end
