#!/usr/bin/env ruby

# file: drb_sqlite.rb

require 'drb'
require 'c32'


class SQLiteServerError < Exception
end

class DRbSQLite
  using ColouredText

  def initialize(raw_dbfile=nil, host: nil, port: '57000', debug: false)
    
      
    @host, @port, @debug = host, port, debug
    
    puts 'inside DRbSQLite'.info if @debug
    
    DRb.start_service
    
    if raw_dbfile then
      load_db(raw_dbfile)
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
  
  def load_db(raw_dbfile)
    
    puts 'DRbSQLite | inside load_db'.info if @debug
    
    if raw_dbfile =~ /^sqlite:\/\// then
      host, @dbfile = raw_dbfile\
          .match(/(?<=^sqlite:\/\/)([^\/]+)\/(.*)/).captures
      
      if @debug then
        puts ('host: ' + host.inspect).debug
        puts ('@dbfile: ' + @dbfile.inspect).debug
      end
      
      @server = DRbObject.new nil, "druby://#{host}:#{@port}"
    else
      @dbfile = raw_dbfile
      @server = DRbObject.new nil, "druby://#{@host}:#{@port}"
    end

    @server.load_db(@dbfile)
  end

  def results_as_hash()
    @server.results_as_hash @dbfile
  end
  
  def results_as_hash=(val)
    puts 'inside results_as_hash=()'.info if @debug
    @server.results_as_hash = [@dbfile, val]
  end
  
  def table_info(s)
    @server.table_info @dbfile, s
  end
  
  def query(*args, &blk)
    
    r = @server.query @dbfile, *args, &blk
    
    if r.is_a? String and r =~ /^SQLiteServerError:/ then
      raise SQLiteServerError, r[/(?<=^SQLiteServerError: )(.*)/]
    end
    
    r    
  end
    
end
