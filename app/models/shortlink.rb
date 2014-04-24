class Shortlink < ActiveRecord::Base
  belongs_to :owner,
    :class_name => "User",
    :foreign_key => "owner_id",
    :primary_key => "id"
  belongs_to :target_url
  has_many :page_views

  validates :target_url_id, :presence => true

  delegate :url, :to => :target_url, :prefix => false

  def generate_code!
    # If I wanted to use a base 64 scheme I'd have
    # to roll my own num to string logic, but base 32
    # seems sufficient for my needs.
    self.code = (self.id + 2000).to_s(36).upcase
    save!
  end
end
