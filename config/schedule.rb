# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

#cornをまだ実行してない。

every 1.monthes do
    
    date = Date.today- 2.months
    first_date = Date.new(date 1) #指定した月の初日
    last_date = Date.new(date -1) #指定した月の最終日
    
    range = (first_date..last_date)
    
    runner  Schedule.destroy(date: range)
    #rake "my:rake:task"
    #command "/usr/bin/my_great_command"
    
end



every 30.monthes do 
    @reservation = Reservation.where(frame_status: 'keep')
    
    runner @reservation.update(frame_status: 'available')
    
end