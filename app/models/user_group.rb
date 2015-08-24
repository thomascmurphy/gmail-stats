class UserGroup < ActiveRecord::Base
  has_many :users
  has_many :admins

  before_create :set_last_update
  def set_last_update
    self.last_update = Time.now
  end

end
