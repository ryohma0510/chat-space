class GroupsController < ApplicationController
before_action :user_belongs_to_group?, only: :show
before_action :get_group, only: [:show, :edit]

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
    @users = @group.users
  end

  def edit
  end

  def update
    Group.find(params[:id]).update(name: group_params[:name])
    group_params[:user_ids].each do |user_id|
      UsersGroup.create(user_id: user_id, group_id: params[:id] ) unless user_id.empty?
    end
    redirect_to group_path(params[:id]), notice: 'グループ更新に成功しました'
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids:[])
  end

  def user_belongs_to_group?
    redirect_to :root unless current_user.groups.ids.include?(params[:id].to_i)
  end

  def get_group
    @group = Group.find(params[:id])
  end
end
