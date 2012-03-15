## What

Failsafe is a tiny library that makes it easy to make sure non-critical exceptions
don't interrupt program flow. It uses a failure handling system heavily inspired
by [Resque's](http://github.com/defunkt/resque). 

You can use failsafe to suppress exceptions from your users, but continue to deliver
them to your errors backends (log files, airbrake, etc).

## Usage

```ruby
class MyApp < Sinatra::Base
  get '/' do
    Failsafe.failsafe { track_some_metrics; raise("boom!") }
    status(200)
  end
end
```

## Configuration

Failsafe comes with 3 error backends by default: Airbrake, File, and Stderr.
You must add them to the failsafe configuration in order to log exceptions
to them:

```ruby
Failsafe::Config.error_backends << Failsafe::Backends::Airbrake
Failsafe::Config.error_backends << Failsafe::Backends::Stderr
```

The File backend logs to a log file in the log directory called failsafe_errors.log.