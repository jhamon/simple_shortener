class Api::ShortlinksController < ApplicationController
  def create
    begin
      lookup_or_create_target_url
      build_shortlink
      render :json => @short_link
    rescue
      render :status => :bad_request
    end
  end

  private
    def lookup_or_create_target_url
      existing_target = TargetUrl.find_by_formatted_url(url_params[:url])
      @target_url = !!existing_target ? existing_target : TargetUrl.create(url_params)
    end

    def build_shortlink
      @short_link = @target_url.shortlinks.create
      @short_link.generate_code!
    end

    def url_params
      params.require(:shortlink).permit(:url)
    end
end
