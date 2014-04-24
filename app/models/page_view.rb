class PageView < ActiveRecord::Base
  belongs_to :shortlink
  belongs_to :target_url
  
  def create
    @shortlink = ShortLink.find_by_code(params[:id]);
    PageView.create(@shortlink)
    redirect_to @shortlink.url
  end
end
