class User < ActiveRecord::Base
  
  after_initialize :set_as_standard

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
  true if owns?(issue) || admin?
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
  true if self.role == :admin
end

def role_name
  User.user_roles.key(self.role)
end

def self.user_roles
  USER_ROLES
end


end
