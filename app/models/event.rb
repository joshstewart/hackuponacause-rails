class Event < ActiveRecord::Base

  before_save :event_hash

  def url
    "http://www.suwn.org/eventDetails.aspx?d=#{self.guid}"
  end

  def as_json(options={})
    super.as_json(options).merge({:url => url})
  end
  
  protected
  
  def event_hash
    
    checksum = Digest::MD5.hexdigest("#{self.location}#{self.start_date}#{self.end_date}")
    
    if self.nil? || self.checksum != checksum
      self.checksum = checksum
    end
    
  end
end
