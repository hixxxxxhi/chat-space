class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group), notice: "グループが作成されました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: "グループが編集されました。"
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, {user_ids: []})
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
