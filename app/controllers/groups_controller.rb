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
    unless group.save
      redirect_to new_group_path, alert: 'グループ登録に失敗しました'
    else
      redirect_to group_path(group.id), notice: 'グループ登録に成功しました'
    end
  end

  def show
    @groups = current_user.groups
    @group = Group.find(params[:id])
    @users = @group.users
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids:[])
  end

  def user_belongs_to_group?
    redirect_to :root unless current_user.groups.ids.include?(params[:id].to_i)
  end
end
