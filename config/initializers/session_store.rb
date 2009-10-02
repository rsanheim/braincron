# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_brainjo_session',
  :secret      => '02f10e633c4911e6234e0077c5b5d16bbc2508d80dc6788dadcb334f4df228ab89a60c7a2976a436461e65a08a44474f17d5bdeaeeb8fa2813dba8a6140ecd7b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
