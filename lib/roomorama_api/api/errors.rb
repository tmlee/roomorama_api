module RoomoramaApi
	module Api
  	module Errors

  		#According to https://www.roomorama.com/api/documentation

  		class BadRequest < StandardError
  			def initialize
  				super("Bad Request")
  			end	
  		end
		  
		  class Unauthorized < StandardError
  	   	def initialize
  	   		super("You're not authorized to access this resource, make sure you're sending the right authorization header in your request")
  	   	end	
		  end
		    
		  class General < StandardError
  	   	def initialize
  	   		super("Generic error")
  	   	end	
		  end
    
		  class Unavailable < StandardError
  	   	def initialize
  	   		super("Unavailable")
  	   	end	
		  end
    
		  class UnprocessableEntity < StandardError
  	   	def initialize
  	   		super("Something went wrong while saving or updating your object, make sure the data you're sending in the request is correct")
  	   	end	
		  end
    
		  class InternalError < StandardError
  	   	def initialize
  	   		super("An error has occurred in Roomorama service")
  	   	end	
		  end
    
		  class NotFound  < StandardError
  	   	def initialize
  	   		super("The resource doesn't exist")
  	   	end	
		  end
    
		  class Conflict  < StandardError
  	   	def initialize
  	   		super("The request cannot be performed because of the state the resource is in")
  	   	end	
		  end
    
		  # HTTP code => error class mapping
    
  	  HTTP_STATUS_ERRORS = {
  	  	400 => BadRequest,
  	  	401 => Unauthorized,
  	  	403 => General,
  	  	404 => NotFound,
  	  	409 => Conflict,
  	  	422 => UnprocessableEntity,
  	  	500 => InternalError,
  	  	502 => Unavailable,
  	  	503 => Unavailable
  	  }

  	end # end module Errors 
  end # end module Api
end # end module RoomoramaApi
  			