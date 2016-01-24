# Client for google api
class GoogleAPIClient
  require 'google/apis/calendar_v3'
  @calendar = Google::Apis::CalendarV3::CalendarService.new

  @calendar.key = ENV['GOOGLE_API_KEY']

  def self.get_calendar_events(max_results = 100)
    @calendar.list_events(ENV['GOOGLE_CALENDAR_ID'],
                          max_results: max_results,
                          time_min: Time.now.iso8601,
                          fields: 'items(summary,start,end,location)'
                         ).items
  end
end
