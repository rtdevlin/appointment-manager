class Appointment < ApplicationRecord

  def self.create_from_event(event)
    create(
      event_id: event.event_id,
      description: event.description,
      date: event.start.date,
      time: event.start.datetime,
      location: event.location,
      html_link: event.html_link
    )
  end
end
