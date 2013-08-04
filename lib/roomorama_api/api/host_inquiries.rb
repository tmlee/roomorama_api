module RoomoramaApi
	module Api
  	module HostInquiries
  	  def host_inquiries_list(options={})
  	    api_call "host/inquiries.json", options
  	  end
  	  
  	  def host_inquiries_show(inquiry_id, options={})
  	    api_call "host/inquiries/#{inquiry_id}.json", options
  	  end
  	end
  end
end