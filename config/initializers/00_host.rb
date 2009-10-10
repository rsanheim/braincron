host = if Rails.env.production?
  metadata_script = Rails.root.join("script", "ec2-metadata")
  `#{metadata_script} --public-hostname`.strip
else
  "localhost"
end

HOST = host
DO_NOT_REPLY = "donotreply@#{HOST}.com"