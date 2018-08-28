#!/usr/bin/env ruby

# file: drb_sqlite.rb

require 'drb'


class DRbSQLite

  def initialize(dbfile=nil, host: nil, port: '57000')
    
    @dbfile = dbfile
    DRb.start_service
    @server = DRbObject.new nil, "druby://#{host}:#{port}"    
    @server.load(dbfile)
        
  end
  
  def execute(*args, &blk)
    @server.execute @dbfile, *args, &blk
  end
  
  def query(*args, &blk)
    @server.query @dbfile, *args, &blk
  end
    
end

