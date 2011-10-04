class Log
  include Mongoid::Document
  
  field :time, :type => Time
  field :user
  field :entry

  def self.make(user_id, entry)
    log = Log.new(:time => Time.now, :user => user_id)
    log.entry = entry
    log.save!
  end


end
