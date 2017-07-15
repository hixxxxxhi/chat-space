class UsersController < ApplicationController
  def search
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").where.not("id = ?", current_user)
    respond_to do |format|
      format.json
    end
  end
end
