module ApplicationHelper
  def title(page_title, sup_title = "")
	    content_for(:title, page_title.to_s )
	end
  
  
end
