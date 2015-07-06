class UsersController < ApplicationController

def edit
end

def update
  if current_user.update_attributes(user_params)
    flash[:notice] = "User information updated"
    redirect_to edit_user_registration_path
    else
    flash[:error] = "Invalid user information"
    redirect_to edit_user_registration_path
  end
end

def show
end


def downgrade

  if current_user.set_as_standard
    flash[:notice] = "Successfully Downgraded"
    redirect_to edit_user_registration_path
  else
    flash[:error]= "There was an issue Downgrading, please try again."
    redirect_to edit_user_registration_path
  end
end



private

def user_params
  params.require(:user).permit(:name, :avatar)
end






end