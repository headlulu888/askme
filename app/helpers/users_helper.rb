module UsersHelper
  def user_username(user_id)
    user = User.find_by(id: user_id)

    if user
      user.username
    end
  end
end
