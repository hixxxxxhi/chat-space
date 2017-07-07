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
    @message = group.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(group) }
        format.json
      end
    else
      redirect_to group_messages_path(group), alert: "メッセージを入力してください。"
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end
end
