if ENV['SENTRY_URL']
  Raven.configure do |config|
    config.dsn = ENV['SENTRY_URL']
  end
end
