namespace :twilio do
  desc "Do things with Twilio"
  task send_events: :environment do
    require 'twilio-ruby'

    # Your Account Sid and Auth Token from twilio.com/console
    # DANGER! This is insecure. See http://twil.io/secure
    account_sid = ENV['twilio_sid']
    auth_token = ENV['twilio_auth_token']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    body = "Hey everyone, this is Ryan. Please text the group chat to let me know if you received this message.\n Thanks!"

    Driver.all.each do |driver|
      @client.messages.create(
           body: body,
           from: '5672053654',
           to: driver.phone_number
         )
    end

  end

end
