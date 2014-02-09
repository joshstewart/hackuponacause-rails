class EventParser
  
  attr_accessor :guid, :title, :description, :date, :location, :start_date, :end_date, :long_description
  
  def initialize(event)
    self.guid = parse_guid(event.entry_id)
    self.title = clean_title(event.title)
    self.description = event.summary
    self.date = event.date
    fetch_and_parse_ics(event.url)
  end
    
  protected
  
  def parse_guid(guid)
    guid.gsub(/^.*?\=/, '')
  end
  
  def clean_title(title)
    title.gsub(/\d{2}\/\d{2}\/\d{4}\s+\-\s+/, '')
  end
  
  def fetch_and_parse_ics(url)

    a = Mechanize.new
    
    a.get(url) do |page|
      form = page.forms.last
      response = a.submit(form, form.buttons.first)
      
      ics_data = response.body

      cal = Icalendar.parse(ics_data)
      
      event_details = cal.first.events.first

      self.location = event_details.location
      self.start_date = event_details.dtstart
      self.end_date = event_details.dtend
      self.long_description = event_details.description
      
      #binding.pry
    end
     
  end
end
