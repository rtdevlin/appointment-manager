namespace :twilio do
  desc "Do things with Twilio"
  task send_events: :environment do
    require 'twilio-ruby'

    #Get the next weeks appointments
    #appointments = Appointment.where('date in (?)', (Date.tomorrow)..(1.week.from_now))
    appointments = Appointment.where(driver_id: nil)
    #Create a new message
    message = Message.create
    #Create a MessageLine for each Appointment
    message_lines = []
    appointments.each.with_index(1) do |appt, index|
      message_lines << MessageLine.create(message_id: message.id, appointment_id: appt.id, order: index)
    end
    #Make message body
    body = []
    message_lines.each do |ml|
      appointment = ml.appointment
      body << "#{ml.order}) #{appointment.start_time.in_time_zone('Eastern Time (US & Canada)').strftime("%m/%d %I:%M%p")} #{appointment.description[0..14]}"
    end
    message_body = body.join("\n")
    #Send Message

    # Your Account Sid and Auth Token from twilio.com/console
    # DANGER! This is insecure. See http://twil.io/secure
    account_sid = ENV['twilio_sid']
    auth_token = ENV['twilio_auth_token']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    Driver.where(first_name: 'Ryan').each do |driver|
      @client.messages.create(
           body: message_body,
           from: '5672053654',
           to: driver.phone_number
         )
    end

  end

end
