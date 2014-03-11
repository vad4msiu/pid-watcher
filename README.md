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

## Example
    $ cd /rails/app/ && bundle
    $ ps ax | grep bundle
    58537 s002  R+     0:01.31 /Users/10525/.rbenv/versions/2.0.0-p353/bin/ruby /Users/10525/.rbenv/versions/2.0.0-p353/bin/bundle
    $ pid-watcher 58537
On completion

![Image](screenshot.png?raw=true)
