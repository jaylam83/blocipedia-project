# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string
#

class User < ActiveRecord::Base
  
  after_create :set_as_standard

  has_many :wikis
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


# Implementation of Authorization

   USER_ROLES = {
    :admin => 'admin',
    :standard => 'standard',
    :premium => 'premium',
   }

#Setting the role
def set_as_admin
  self.role = USER_ROLES[:admin]
end

def set_as_standard
  self.role = USER_ROLES[:standard]
end

def set_as_premium
  self.role = USER_ROLES[:premium]
end

#Defining permissions
def can_edit?(issue)
  true if (owns?(issue) || admin?)
end

def can_destroy?(issue)
  true if owns?(issue) || admin?
end

def can_update?(issue)
  true if owns?(issue) || admin?
end

#defining role methods

def owns?(issue)
  true if self.id == issue.user_id
end

def admin?
  true if self.role == USER_ROLES[:admin]
end

def role_name
  User.user_roles.key(self.role)
end

def self.user_roles
  USER_ROLES
end


end
