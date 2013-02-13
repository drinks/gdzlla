module GDZLLA
  def self.setting(key, val=nil)
    SETTINGS[key.to_s] = val if val.present?
    SETTINGS[key.to_s] rescue nil
  end
end