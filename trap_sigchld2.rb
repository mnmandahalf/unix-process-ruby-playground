child_processes = 3
dead_processes = 0
child_processes.times do
  fork do
    puts "I'm #{Process.pid}"
    sleep 3
  end
end

$stdout.sync = true

trap(:CHLD) do
  begin
    while pid = Process.wait(-1, Process::WNOHANG)
      puts pid
      dead_processes += 1
    end
  rescue Errno::ECHILD
  end
end

at_exit { puts "Bye!" }
loop do
  exit if dead_processes == child_processes
  sleep 1
end

