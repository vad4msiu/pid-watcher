require 'terminal-notifier'
require 'timeout'

class PidWatcher
  VERSION = "0.0.2"
  DEFAULT_TIMEOUT = 10 * 60
  DEFAULT_MESSAGE = "Process %{pid} finished"
  TIMEOUT_MESSAGE = "Timeout for process %{pid}"
  TITLE           = 'Pid Watcher'

  def initialize(pid, options)
    @pid     = pid
    @message = options[:message] || DEFAULT_MESSAGE
    @timeout = options[:timeout] || DEFAULT_TIMEOUT
    @command = options[:command]
  end

  def watch
    Process.daemon

    Timeout::timeout(timeout) do
      while pid_exists?
        sleep(1)
      end
      run_command unless command.nil?
      finish_notify
    end
  rescue Timeout::Error
    timeout_notify
  end

  private

  def run_command
    Process.spawn(command)
  rescue
    true
  end

  def pid_exists?
    status = Process.kill(0, pid) rescue false
    !!status
  end

  def finish_notify
    prepared_msg = message % { :pid => pid }
    prepared_msg += " and '#{command}' was running in background" unless command.nil?

    TerminalNotifier.notify(
      prepared_msg,
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

  attr_reader :pid, :message, :timeout, :command
end
