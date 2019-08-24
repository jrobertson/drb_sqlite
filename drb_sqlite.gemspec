Gem::Specification.new do |s|
  s.name = 'drb_sqlite'
  s.version = '0.3.3'
  s.summary = 'Connects to a remote SQLite database (sqlite_server2018 gem).'
  s.authors = ['James Robertson']
  s.files = Dir['lib/drb_sqlite.rb']
  s.add_runtime_dependency('c32', '~> 0.1', '>=0.1.2')
  s.signing_key = '../privatekeys/drb_sqlite.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/drb_sqlite'
end
