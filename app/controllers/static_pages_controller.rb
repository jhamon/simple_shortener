class StaticPagesController < ApplicationController
  def root
    @target_url = TargetUrl.new()
    render :root
  end
end