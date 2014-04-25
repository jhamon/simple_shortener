class TargetUrl < ActiveRecord::Base
  has_many :shortlinks
  has_many :users, :through => :shortlinks
  has_many :page_views

  validates :url, :presence => true

  before_save :format_url, :on => :create

  PROTOCOLS = ["http://", "https://"] 
  DEFAULT_PROTOCOL = 'http://'

  def self.has_protocol?(url)
    PROTOCOLS.any? { |protocol| url.start_with?(protocol) }
  end

  def format_url
    unless self.class.has_protocol?(self.url)
      self.url = DEFAULT_PROTOCOL + self.url 
    end
  end

  def self.find_by_formatted_url(url)
    if has_protocol?(url)
      return self.find_by_url(url)
    else
      return self.find_by_url(DEFAULT_PROTOCOL + url)
    end
  end
end
