RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
    Capybara.javascript_driver = :poltergeist
  end

  config.before :each do |example|
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
