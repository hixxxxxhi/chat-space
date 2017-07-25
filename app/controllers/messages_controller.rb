class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, :set_message, only: [:index, :create]

  def index
    set_messages
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group) }
        format.json
      end
    else
      set_group
      set_message
      set_messages

      flash.now[:alert] = "メッセージを入力してください。"
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_message
    @message = Message.new
  end

  def set_messages
    @messages = @group.messages.includes(:user)
  end
end
