class GoogleApiBase

  ## Email of the Service Account #
  SERVICE_ACCOUNT_EMAIL = '803773653155-halsviujefi73qumbccbre24omm8g81f@developer.gserviceaccount.com'
  ADMIN_EMAIL = "thomas.murphy@bawte.com"

  ## Path to the Service Account's Private Key file #
  SERVICE_ACCOUNT_PKCS12_FILE_PATH = "#{Rails.root}/lib/assets/Gmail Stats-ef5eaf0e3382.p12"

  APPLICATION_NAME = 'Gmail Stats'

  ##
  # Build a Drive client instance authorized with the service account
  # that acts on behalf of the given user.
  #
  # @param [String] user_email
  #   The email of the user.
  # @return [Google::APIClient]
  #   Client instance
  def build_client_labels(user_email)
    require 'google/api_client'
    key = Google::APIClient::PKCS12.load_key(SERVICE_ACCOUNT_PKCS12_FILE_PATH, 'notasecret')
    asserter = Google::APIClient::JWTAsserter.new(SERVICE_ACCOUNT_EMAIL,
        'https://www.googleapis.com/auth/gmail.labels', key)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = asserter.authorize(user_email)
    client
  end

  def build_client_users()
    require 'google/api_client'
    key = Google::APIClient::PKCS12.load_key(SERVICE_ACCOUNT_PKCS12_FILE_PATH, 'notasecret')
    asserter = Google::APIClient::JWTAsserter.new(SERVICE_ACCOUNT_EMAIL,
        'https://www.googleapis.com/auth/admin.directory.user.readonly', key)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = asserter.authorize(ADMIN_EMAIL)
    client
  end
end
