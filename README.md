# Pid Watcher

This program will allow you to observe the process, and when the process is complete, you will be notified.

## Installation
    gem install pid-watcher

## Supported platform
Only Mac OS version >= 10.8

## Usage
    $ pid-watcher -h
    Usage: pid-watcher PID [options]
      -m, --message MESSAGE            Message for Notification Center (default: Process %{pid} finished)
      -t, --timeout TIMEOUT            Timeout in seconds for process (default: 600)
      -v                               Show version
