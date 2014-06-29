module ApplicationHelper

	def set_title(title)
		title_arr = ['iFrogCRM']

		if title.is_a?(Array)
			title_arr.concat( title )
		else
			title_arr.push( title )
		end
		puts title.join(" » ")
		content_for(:title) { title_arr.reverse.join(" » ") }
	end
end
