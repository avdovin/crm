class Crm::Domain < ActiveRecord::Base
	belongs_to  :access

	validates :name, :presence => {:message => 'Укажите имя домена'}, :uniqueness => {:message => 'Такой домен уже добавлен'}
end
