require "json"
module Google
  class Calendars

    def initialize(params={}, connection=nil)

      counter = 0
      @googleCalendars = Array.new
      params[:calendars].each do |x|
        @googleCalendars[counter]= {}
        @googleCalendars[counter][:id] = x[:id]
        @googleCalendars[counter][:connection] = Google::Freebusy.new(:client_id     => params[:client_id],
                                                                      :client_secret => params[:client_secret],
                                                                      :refresh_token => x[:refresh_token],
                                                                      :redirect_url  => params[:redirect_url] # this is what Google uses for 'applications'
        )
        counter = counter + 1
      end
    end


    # new method to get busy slots
    def get_busy_slots(start_min, start_max)
      result = Array.new
      @googleCalendars.each do |x|
        result.push(x[:connection].query([x[:id]],start_min, start_max))
      end
      return result
    end


  end
end
