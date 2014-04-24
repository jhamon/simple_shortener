class TargetUrl < ActiveRecord::Base
  has_many :shortlinks
  has_many :users, :through => :shortlinks
  has_many :page_views

  validates :url, :presence => true
end
