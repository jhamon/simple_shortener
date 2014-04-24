require 'spec_helper'

describe TargetUrl do
  it { should have_many(:shortlinks) }
  it { should validate_presence_of(:url) }

  it "validates the format of the url"
end
