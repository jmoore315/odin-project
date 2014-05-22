class XmlDocument
	def initialize(indent=false)
		@indent = indent
		@indent_count = 0
	end

	def method_missing(method, *args, &block)
		result = ""
		if @indent && @indent_count > 0
			result += "\n" + "  "*@indent_count
		end
		result += "<#{method}"
		unless args[0].nil?
			result += " "
			args[0].each do |k,v| 
				result += "#{k}='#{v}'"
			end
		end

		if block 
			@indent_count += 1
			result += ">#{yield}"
			result += "  "*@indent_count if @indent
			result += "</#{method}>"
		else
			result += "/>"
		end
		result += "\n" if @indent
		@indent_count -= 1
		result
	end
end
