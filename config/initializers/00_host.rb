host = if Rails.env.production?
  metadata_script = Rails.root.join("script", "ec2-metadata")
  `#{metadata_script} --public-hostname`.gsub("public-hostname: ", "").strip
else
  "localhost"
end

HOST = host
DO_NOT_REPLY = "braincron@#{HOST}.com"