if Rails.env.production?
  CarrierWave.configure do |c|
    c.fog_credentials = {
      provider: "AWS",
      region: "eu-west-1",
      aws_access_key_id:     ENV["S3_ACCESS_KEY"],
      aws_secret_access_key: ENV["S3_SECRET_KEY"]
    }
    c.fog_directory = ENV["S3_BUCKET"]
  end
end
