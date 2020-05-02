class AppointmentsController < ApplicationController
  before_action :set_appointments, only: [:show, :update, :destroy]


  # GET /appointments/1
  def show
    render json: @appointment
  end

  def update
    @driver = Driver.where(phone_number: params[:From][2..]).first
    @appointments.each  do |appt|
      appt.update(driver_id: @driver.id)
    end
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message body: 'Thanks for your response!'
    end

    render xml: twiml.to_s
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointments
      @appointments = []
      latest_message = Message.order('created_at').last
      lines = latest_message.message_lines.where(order: params[:Body].split(' ').map(&:to_i))
      lines.each do |line|
        @appointments << line.appointment
      end
    end

end
