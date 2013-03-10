module RoomoramaApi
	class User
		attr_accessor :id,:login,:email,:first_name,:last_name,:phone_number,:city,:country,:email2,:description,:date_of_birth,:locale,:time_zone,:shoutouts_notifications_frequency,:wants_unresponded_inquiries_notification,:wants_daily_guest_summary_notification,:gender,:url,:role,:payment_country,:wants_mailings,:created_at,:updated_at,:payment_method

		def initialize attributes={}
			attributes.each do |key, value|
				self.send "#{key}=", value
			end
		end

	end
end