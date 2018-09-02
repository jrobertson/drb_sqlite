#!/usr/bin/env ruby

# file: drb_sqlite.rb

require 'drb'

class SQLiteServerError < Exception
end

class DRbSQLite

  def initialize(raw_dbfile=nil, host: nil, port: '57000')
        
    @port = port
    
    DRb.start_service
    
    if raw_dbfile then
      load(raw_dbfile)
    else
      @server = DRbObject.new nil, "druby://#{host}:#{port}"
    end    
        
  end
  
  def execute(*args, &blk)
    
    r = @server.execute @dbfile, *args, &blk
    
    if r.is_a? String and r =~ /^SQLiteServerError:/ then
      raise SQLiteServerError, r[/(?<=^SQLiteServerError: )(.*)/]
    end
    
    r
  end
  
  def exists?(dbfile)
    @server.exists? dbfile
  end
  
  def load(raw_dbfile)
    
    if raw_dbfile =~ /^sqlite:\/\// then
      host, @dbfile = raw_dbfile\
          .match(/(?<=^sqlite:\/\/)([^\/]+)\/(.*)/).captures
      @server = DRbObject.new nil, "druby://#{host}:#{@port}"
    else
      @dbfile = raw_dbfile
    end

    @server.load(@dbfile)
  end
  
  def query(*args, &blk)
    
    r = @server.query @dbfile, *args, &blk
    
    if r.is_a? String and r =~ /^SQLiteServerError:/ then
      raise SQLiteServerError, r[/(?<=^SQLiteServerError: )(.*)/]
    end
    
    r    
  end
    
end
