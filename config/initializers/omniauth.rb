Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'inYP1oEL2R1HFtOhqW4d2Q', 'K6GlIi5WgqykdXq2FXBMf1UTc8QavouysYkf0sVVqeA'
  provider :facebook, '155698654479450', '0ba3b931d4eae0db4db35e4c7d66865c'
end
