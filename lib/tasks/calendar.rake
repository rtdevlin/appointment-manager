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
    auth_client.sub = 'mistydevlin@gmail.com'
    auth_client.fetch_access_token!

    # Initialize the API
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = auth_client

    # Fetch the next 10 events for the user
    calendar_id = 'appointments'
    response = service.list_events(calendar_id,
                                   max_results: 10,
                                   single_events: true,
                                   order_by: 'startTime',
                                   time_min: Time.now.iso8601)
    puts 'Upcoming events:'
    puts 'No upcoming events found' if response.items.empty?
    response.items.each do |event|
      start = event.start.date || event.start.date_time
      puts "- #{event.summary} (#{start})"
    end
  end
end
