class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    Group.create(group_params)
    redirect_to :root
  end

  private

  def group_params
    selected_params = params.require(:group).permit(:name, :group_id, user_ids:[])
    users_groups_array = []
    selected_params[:user_ids].each do |id|
      users_groups_array << { user_id: id, group_id: selected_params[:group_id] }
    end
    return { name: "#{selected_params[:name]}", users_groups_attributes: users_groups_array }
  end
end
