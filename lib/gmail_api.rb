class GmailApi
  # include HTTParty
  # base_uri 'https://www.googleapis.com/gmail'
  #
  # def initialize(user_id, query={})
  #   @options = { query: query.merge!(key: "AIzaSyBzD75X620bP7batFCpEX4oN_l8optUH0s") }
  #   @user_id = user_id
  # end
  #
  # def get_label(label_id)
  #   self.class.get("/v1/users/#{@user_id}/labels/#{label_id}", @options)
  # end

  DOMAIN = "bawte.com"

  def get_label(user_id, label_id)
    require 'google_api_base'
    google_api_base = GoogleApiBase.new()
    client = google_api_base.build_client_labels(user_id)
    gmail_api = client.discovered_api('gmail', 'v1')
    stats = client.execute!(
      :api_method => gmail_api.users.labels.get,
      :parameters => { :userId => user_id, :id => label_id })
    stats.data
  end

  def get_users()
    require 'google_api_base'
    google_api_base = GoogleApiBase.new()
    client = google_api_base.build_client_users()
    gmail_api = client.discovered_api('admin', 'directory_v1')
    stats = client.execute!(
      :api_method => gmail_api.users.list,
      :parameters => { :domain => DOMAIN })
    stats.data
  end



end
