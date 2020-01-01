# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron


set :output, File.join(Whenever.path, "log", "cron.log")
#開発環境と指定。何もしなければ本番環境
set :environment, :development




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

#前の処理を消す。
every 1.month do
    
    rake "my:rake:schedule_task"

    runner  "Schedule.do_somthing"
    
    #command "/usr/bin/my_great_command"
    
end

#scheduleのframe_statusの時間処理
#every 3.minute do 
    
    #rake "my:rake:schedule.fame_status_task"
    #runner "Reservation.change_frame_status"
    
#end

