#!/usr/bin/env ruby 
#-*- coding:utf-8 -*- 

class String
	def is_camel?
		(self =~ /^\w+[A-Z][a-z]*$/) == 0
	end
	def camel_to_snake	
		return self[0]+self[1..-1].gsub(/([A-Z])/,'_\1').downcase if self.is_camel?
		self
	end
end

if $0 == __FILE__
	{
		hello_world:'hello_world',
		helloworld:'helloworld',
		helloWorld:'hello_world',
		HelloWorld:'Hello_world'
	}.each do |key,value|
		puts "#{key.to_s.camel_to_snake==value} #{key} -> #{value}"
	end

end