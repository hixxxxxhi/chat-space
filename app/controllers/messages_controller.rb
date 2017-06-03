class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @group = Group.find(params[:group_id])
    @message = Message.new

    # 現在のグループに所属するユーザの名前を配列に入れる
    # _main.html.haml の "MEMBER: " の箇所でユーザ名を列挙するときに使う
    @users_names = []
    @group.users.each do |user|
      @users_names << user.name
    end
  end

  def create
    group = Group.find(params[:group_id])
    @message = group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(group)
    else
      redirect_to group_messages_path(group), alert: "メッセージを入力してください。"
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end
end
