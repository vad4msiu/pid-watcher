require 'terminal-notifier'
require 'timeout'

class PidWatcher
  VERSION = "0.0.1"
  DEFAULT_TIMEOUT = 10 * 60
  DEFAULT_MESSAGE = "Process %{pid} finished"
  TIMEOUT_MESSAGE = "Timeout for process %{pid}"
  TITLE           = 'Pid Watcher'

  def initialize(pid, message = nil, timeout = nil)
    @pid     = pid
    @message = message || DEFAULT_MESSAGE
    @timeout = timeout || DEFAULT_TIMEOUT
  end

  def watch
    Process.daemon(nil, true)

    Timeout::timeout(timeout) do
      while pid_exists?
        sleep(1)
      end
      finish_notify
    end
  rescue Timeout::Error
    timeout_notify
  end

  private

  def pid_exists?
    status = Process.kill(0, pid) rescue false
    !!status
  end

  def finish_notify
    TerminalNotifier.notify(
      message % { :pid => pid },
      :title => TITLE,
      :subtitle => 'Finished'
    )
  end

  def timeout_notify
    TerminalNotifier.notify(
      TIMEOUT_MESSAGE % { :pid => pid },
      :title    => TITLE,
      :subtitle => 'Timeout'
    )
  end

  attr_reader :pid, :message, :timeout
end
