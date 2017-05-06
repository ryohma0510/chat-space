CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_API_KEY'],
    aws_secret_access_key: ENV['AWS_API_SECRET'],
    region:                ENV['AWS_REGION'],
    path_style:            true
  }

  config.fog_directory  = ENV['AWS_S3_BUCKET']
  config.storage        = :fog
end
