Gem::Specification.new do |s|
  s.name = 'drb_sqlite'
  s.version = '0.2.0'
  s.summary = 'Connects to a remote SQLite database (sqlite_server2018 gem).'
  s.authors = ['James Robertson']
  s.files = Dir['lib/drb_sqlite.rb']
  s.signing_key = '../privatekeys/drb_sqlite.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/drb_sqlite'
end
