module RoomoramaApi
  module Users
    def users_me(options={})
      api_call "me", options
    end

    def users_update_profile(options={})
      api_call "me", options, :put
    end

    def users_get_data(user_id, options={})
      api_call "users/" + user_id.to_s, options
    end

    def users_register(options={})
      api_call "users", options, :post
    end

    def users_reviews(user_id, options={})
      api_call "users/" + user_id.to_s + "/reviews", options
    end
  end
end