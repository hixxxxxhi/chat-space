class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @group = Group.find(params[:group_id])
    @message = Message.new
  end

  def create
    group = Group.find(params[:group_id])
    @message = Message.new(body: message_params[:body], group_id: params[:group_id], user_id: current_user.id)
    if @message.save
      redirect_to group_messages_path(group)
    else
      redirect_to group_messages_path(group), alert: "メッセージを入力してください。"
    end
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end
end
