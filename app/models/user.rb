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
    gmail_api = GmailApi.new(self.email)
    gmail_stats = gmail_api.get_label("INBOX")
    self.inbox_total = gmail_stats["threadsTotal"]
    self.inbox_unread = gmail_stats["threadsUnread"]

    #gplus_api = GplusApi.new(self.email)
    #gplus_profile = gplus_api.get_profile()
    #self.profile_image_url = gplus_profile["image"]["url"]

    self.save()
  end

  private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

end
