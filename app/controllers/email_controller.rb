class EmailController < ApplicationController
  
  def index
    event, time = params['body-plain'].split(' at ')
    start_time = Chronic.parse(time)
    end_time = (start_time + 1.hour).iso8601
    start_time = start_time.iso8601
    xml = <<-eos
    <entry xmlns='http://www.w3.org/2005/Atom'
        xmlns:gd='http://schemas.google.com/g/2005'>
      <category scheme='http://schemas.google.com/g/2005#kind'
        term='http://schemas.google.com/g/2005#event'></category>
      <title type='text'>#{event}</title>
      <gd:transparency
        value='http://schemas.google.com/g/2005#event.opaque'>
      </gd:transparency>
      <gd:eventStatus
        value='http://schemas.google.com/g/2005#event.confirmed'>
      </gd:eventStatus>
      <gd:when startTime='#{start_time}'
        endTime='#{end_time}'></gd:when>
    </entry>
    eos
    client = GData::Client::DocList.new
    client.authsub_token = User.where(:email => params[:sender]).access_token
    client.post('https://www.google.com/calendar/feeds/default/private/full', xml)
    render json: {:success => true}
  end

end
