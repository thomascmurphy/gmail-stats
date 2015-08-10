class Admin < ActiveRecord::Base
  belongs_to :user_group
  before_validation :downcase_email
  validates :email, :presence => true, :uniqueness => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def users
    User.where(user_group: self.user_group)
  end

  def users_count
    self.users.count()
  end

  def impersonating_admin
    if self.superadmin? && self.impersonating_id.present?
      Admin.find(self.impersonating_id)
    else
      nil
    end
  end
  
  private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

end
