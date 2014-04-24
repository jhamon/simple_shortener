class Api::TargetUrlsController < ApplicationController
  def create
    @target_url = TargetUrl.new(url_params)
    if @target_url.save
      @short_link = @target_url.shortlinks.create
      @short_link.generate_code!
      render :json => @short_link
    else
      render :status => :bad_request
    end
  end

  private
    def url_params
      params.require(:target_url).permit(:url)
    end
end
