class GplusApi
  include HTTParty
  base_uri 'https://www.googleapis.com/plus'

  def initialize(user_id, query={})
    @options = { query: query.merge!(key: "AIzaSyBzD75X620bP7batFCpEX4oN_l8optUH0s") }
    @user_id = user_id
  end

  def get_profile
    self.class.get("/v1/people/#{@user_id}", @options)
  end

end
