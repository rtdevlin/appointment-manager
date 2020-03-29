namespace :calendar do
  desc "Create records for Events that don't already exist"
  task get_events: :environment do
    require 'google/apis/calendar_v3'
    require 'googleauth'

    # Get the environment configured authorization
    scopes =  ['https://www.googleapis.com/auth/calendar']
    authorization = Google::Auth.get_application_default(scopes)

    # Clone and set the subject
    auth_client = authorization.dup
    auth_client.sub = ENV['service_name_email']
    auth_client.fetch_access_token!

    # Initialize the API
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = auth_client

    # Fetch the next 10 events for the user
    calendar_id = ENV['calendar_id']
    response = service.list_events(calendar_id)
    response.items.each do |event|
      Appointment.create_from_event(event)
    end
  end
end
