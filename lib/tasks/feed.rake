namespace :feed do
  desc "Fetch Events RSS Feed"
  task :fetch => :environment do
    
    class Feedzirra::Parser::RSSEntry
      element 'date'
      element 'location'
    end
    
    feeds = {
        'National' => 'http://www.suwn.org/eventFeed.ashx',
        'New York' => 'http://www.suwn.org/eventFeed.ashx?l=NY',
        'Los Angeles' => 'http://www.suwn.org/eventFeed.ashx?l=LA',
        'Chicago' => 'http://www.suwn.org/eventFeed.ashx?l=CH'
    }
    
    feeds.each do |area, url|
      puts "Fetching Feed for #{area}"
      
      feed = Feedzirra::Feed.fetch_and_parse(url)

      feed.entries.each_with_index do |item, index|
        
        event = EventParser.new(item)

        obj_hash = {}

        event.instance_variables.each {|var| obj_hash[var.to_s.delete("@")] = event.instance_variable_get(var) }

        obj_hash['area'] = area
        
        if (existing_event = Event.find_by(guid: event.guid))
          existing_event.update_attributes(obj_hash)
        else
          Event.create!(obj_hash)
        end

      end
      
    end
    
  end
end