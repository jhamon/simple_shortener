require 'spec_helper'

describe Shortlink do
  it { should validate_presence_of(:target_url_id) }
  it { should belong_to(:owner) }
  it { should validate_presence_of(:owner_id)}
end
