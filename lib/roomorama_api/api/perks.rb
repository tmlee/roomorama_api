module RoomoramaApi
  module Perks
    def perks_list(options={})
      api_call "perks", options
    end

    def perks_get_data(perk_id, options={})
      api_call "perks/" + perk_id.to_s, options
    end
  end
end