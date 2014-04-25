require 'spec_helper'

describe TargetUrl do
  it { should have_many(:shortlinks) }
  it { should validate_presence_of(:url) }

  it "ensures a protocol is present in the url" do
    target_url = TargetUrl.create(url: "cnn.com")
    expect(target_url.url).to eq("http://cnn.com")
  end

  it "does not modify urls that contain a protocol already" do
    target_url = TargetUrl.create(url: "http://cnn.com")
    expect(target_url.url).to eq("http://cnn.com")
  end

  it "recognizes https protocol as valid" do
    target_url= TargetUrl.create(url: "https://cnn.com")
    expect(target_url.url).to eq("https://cnn.com")
  end

  describe "find_by_formatted_url" do
    it "formats the url string before executing a search" do
      actual = TargetUrl.create(url: 'http://www.cnn.com')
      found = TargetUrl.find_by_formatted_url('www.cnn.com')
      expect(found.id).to equal(actual.id)
    end
  end
end
