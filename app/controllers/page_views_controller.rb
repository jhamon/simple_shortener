class PageViewsController < ApplicationController
  def create
    @shortlink = Shortlink.find_by_code(params[:code])
    @page_view = PageView.create(
      :user_agent => request.user_agent,
      :ip_address => request.ip,
      :referrer => request.referrer,
      :shortlink_id => @shortlink.id
    )
    redirect_to @shortlink.url
  end
end
