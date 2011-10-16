class EmailController < ApplicationController
  
  def index
    xml = <<-eos
    <entry xmlns='http://www.w3.org/2005/Atom' xmlns:gCal='http://schemas.google.com/gCal/2005'>
      <content type="html">Tennis October 16 11 3pm-3:30pm</content>
      <gCal:quickadd value="true"/>
    </entry>
    eos
    client = GData::Client::DocList.new
    client.authsub_token = User.find(1).access_token
    client.post('https://www.google.com/calendar/feeds/default/private/full', xml)
  end

end
