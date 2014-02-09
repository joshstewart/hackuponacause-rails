class Event < ActiveRecord::Base

  before_save :event_hash

  protected
  
  def event_hash
    
    checksum = Digest::MD5.hexdigest("#{self.location}#{self.start_date}#{self.end_date}")
    
    if self.nil? || self.checksum != checksum
      self.checksum = checksum
    end
    
  end
end
