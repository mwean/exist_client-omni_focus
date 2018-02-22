require "time"

require_relative "omni_focus/version"

module ExistClient
  module OmniFocus
    # This script comes from https://github.com/tschoffelen/vibe
    SCRIPT = <<~END
      set theProgressDetail to ""

      tell application "OmniFocus"
        tell front document
          set theModifiedProjects to every flattened project

          repeat with a from 1 to length of theModifiedProjects
            set theCompletedTasks to (every flattened task of (item a of theModifiedProjects) where its number of tasks = 0)

            if theCompletedTasks is not equal to {} then
              repeat with b from 1 to length of theCompletedTasks
                set theProgressDetail to theProgressDetail & completion date of (item b of theCompletedTasks) & return
              end repeat
            end if
          end repeat

          set theInboxCompletedTasks to (every inbox task where its number of tasks = 0)

          repeat with d from 1 to length of theInboxCompletedTasks
            set theProgressDetail to theProgressDetail & completion date of (item d of theInboxCompletedTasks) & return
          end repeat
        end tell
      end tell

      return theProgressDetail
    END

    module_function

    def completed_tasks(_report_period, _data_path)
      data = `osascript -e '#{SCRIPT}'`.strip.split("\r")

      data.reject { |value| value == "missing value" }.map do |time_str|
        { completed_at: Time.parse(time_str) }
      end
    end
  end
end
