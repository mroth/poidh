# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_poidh_session',
  :secret      => '6bc94325209890902438faa8712105ac455205829e82e842ace4037c910d87c4b0979f37113a78a88cef60c5e7fe92209d88c63ebd1dcb7046682c5972da1c71'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
