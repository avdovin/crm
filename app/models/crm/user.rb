class Crm::User < ActiveRecord::Base
	after_destroy :ensure_an_crm_remains

	validates	:nickname, presence: true
	validates	:email, presence: true, uniqueness: true

	has_secure_password

	def self.search(search)
		if search
			wildcard_search = "%#{search}%"
			where("nickname LIKE ? OR email LIKE ?", wildcard_search, wildcard_search)
		else
			all
		end
	end

	private
		def ensure_an_crm_remains
			if Crm::User.count.zero?
				raise "Последний пользователь не может быть удален"
		end
	end
end
