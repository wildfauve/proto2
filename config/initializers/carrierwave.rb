CarrierWave.configure do |config|
  config.storage = :grid_fs

  # Same as your MongoHQ database conenction parameters
  config.grid_fs_connection = Mongoid.database

  # Storage access url
  config.grid_fs_access_url = "/grid"
  
  config.cache_dir = "uploads"
  
  config.root = Rails.root.join('tmp')
  
end