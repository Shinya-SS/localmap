json.extract! @user, :name, :email, :station, :icon, :introduction, :created_at, :updated_at
json.url user_url(@user, format: :json)
