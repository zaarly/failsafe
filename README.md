[![Build Status](https://secure.travis-ci.org/zaarly/failsafe.png?branch=master)](http://travis-ci.org/zaarly/failsafe)

## What

Failsafe is a tiny library that makes it easy to make sure non-critical exceptions
don't interrupt program flow. It uses a failure handling system heavily inspired
by that of [Resque](http://github.com/defunkt/resque). 

You can use failsafe to suppress exceptions from your users, but continue to deliver
them to your errors backends (log files, airbrake, etc).

## Usage

```ruby
Failsafe.error_backends << Failsafe::Backends::Stderr

class MyApp < Sinatra::Base
  get '/' do
    Failsafe.failsafe { track_some_metrics; raise("boom!") }
    status(200)
  end
end
```

## Disabling Failsafe

In production, you want your app to keep ticking along when certain exceptions
occur without missing a beat. However, in development and test environments,
you probably want to know that exceptions are occurring.
Use the `disabled` property for that:

```ruby
if Rails.env.test?
  Failsafe.disabled = true
else
  # not necessary, this is the default setting
  Failsafe.disabled = false 
end
```

## Configuration

Failsafe comes with 4 error backends by default: Airbrake, Exceptiona, File, and Stderr.
You must add them to the failsafe configuration in order to log exceptions
to them:

```ruby
Failsafe.error_backends << Failsafe::Backends::Airbrake
Failsafe.error_backends << Failsafe::Backends::Stderr
```

## Backends

"Backends" are what handle exceptions instead of letting them
bubble up to the user. When an exception occurs within a piece of code wrapped
by failsafe, the exception object is handed to each error backend.

Failsafe ships with four error backends by default:

* Airbrake - Send errors to airbrake
* Exceptional - Send errors to exceptional
* Stderr - Send errors to stderr
* File - Send errors to a log file

Note: The File backend by default logs to a log file in the log directory called
failsafe_errors.log.  It can be optionally configured with a different path:

```ruby
Failsafe::Backends::File.log_file_path = "/path/to/errors.log"
```
