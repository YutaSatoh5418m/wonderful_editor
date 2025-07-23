# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"
    resource "/api/v1/auth/*", # /*を追加
             headers: :any,
             expose: ["access-token", "expiry", "token-type", "uid", "client"],
             methods: [:get, :post, :options, :delete, :put]
  end
end
