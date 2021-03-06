class Appointment < ApplicationRecord
  validates_uniqueness_of :event_id

  def self.create_from_event(event)
    create(
      event_id: event.id,
      description: event.summary,
      start_time: event.start.date_time,
      location: event.location,
      html_link: event.html_link
    )
  end
end
