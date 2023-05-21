child_processes = 3
dead_processes = 0

child_processes.times do
  fork do
    puts "I'm #{Process.pid}"
    sleep 1
  end
end

at_exit { puts "Bye!" }

trap(:CHLD) do
  child_pid, exit_status = Process.wait2
  puts "#{child_pid} is dead by exit code #{exit_status}"
  dead_processes += 1
  puts "#{dead_processes} processes dead."
  exit if dead_processes == child_processes
end

sleep 30

