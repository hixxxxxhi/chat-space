module UsersHelper
  def divide_by_comma(users)
    usernames = []
    users.each do |u|
      usernames << u.name
    end
    usernames.join(", ")
  end
end
