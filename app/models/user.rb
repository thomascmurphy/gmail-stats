class User < ActiveRecord::Base
  before_validation :downcase_email
  validates :email, :presence => true, :uniqueness => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  def full_name
    last_name_parsed = last_name.present? ? last_name : ""
    first_name_parsed = first_name.present? ? first_name : ""
    unless last_name_parsed.blank? && first_name_parsed.blank?
      first_name_parsed  + " " + last_name_parsed
    else
      email
    end
  end

  def update_gmail_stats
    require 'gmail_api'
    require 'gplus_api'
    gmail_api = GmailApi.new()
    gmail_stats = gmail_api.get_label(self.email, "INBOX")
    self.inbox_total = gmail_stats["threadsTotal"]
    self.inbox_unread = gmail_stats["threadsUnread"]

    #gplus_api = GplusApi.new(self.email)
    #gplus_profile = gplus_api.get_profile()
    #self.profile_image_url = gplus_profile["image"]["url"]

    self.save()
  end

  def self.refresh_users(admin_email)
    require 'gmail_api'
    require 'gplus_api'
    gmail_api = GmailApi.new()
    gmail_users = gmail_api.get_users(admin_email)
    gmail_users.users.each do |gmail_user|
      user = User.find_or_create_by(email: gmail_user["primaryEmail"])
      user.first_name = gmail_user["name"]["givenName"]
      user.last_name = gmail_user["name"]["familyName"]
      user.profile_image_url = gmail_user["thumbnailPhotoUrl"]
      user.save()
      user.update_gmail_stats()
    end
    User.all()
  end

  private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

end
