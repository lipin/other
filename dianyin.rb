
require 'open-uri'
require 'nokogiri'

file = File.open('test2','w')
threads = []
i = 0
172.times do |nu|
	 p nu
	 begin
					 	url = "http://www.dytt8.net/html/gndy/dyzz/list_23_#{(nu+1).to_s}.html"
					  html = open(url).read
	rescue
	  	retry
	end
	html.scan(%r{/html/g\w*/\w*/\d*/\d*.html}).each do |str|
				 	threads << Thread.new(i) do
							 	 i += 1
				  			begin
										  html2 = open("http://www.dytt8.net" + str).read.encode('utf-8','GBK') #utf-8是目标编码, gbk是原编码
										  doc = Nokogiri::HTML(html2)
										  data = doc.css('div.title_all h1').inner_text + "\t" + doc.css('div#Zoom table a').inner_text + "\n"
										  file.write(data)
								rescue
									retry
								end
					end
	end
end

