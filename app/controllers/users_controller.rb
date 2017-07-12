class UsersController < ApplicationController
  def search
    respond_to do |format|
      @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").where.not("id = ?", current_user)
      format.json
    end
  end
end
