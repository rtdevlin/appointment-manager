class MessageLine < ApplicationRecord
  belongs_to :message
  belongs_to :appointment
end
