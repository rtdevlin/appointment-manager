class Appointment < ApplicationRecord
  validates_uniqueness_of :event_id

  def self.create_from_event(event)
    create(
      event_id: event.id,
      description: event.summary,
      date: event.start.date_time.to_date,
      time: event.start.date_time.to_time,
      location: event.location,
      html_link: event.html_link
    )
  end
end
