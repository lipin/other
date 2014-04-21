#coding: utf-8
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
# 过程中也熟悉一下ruby的一些http,解析html,
# 字符编码 和 正则的一些东西-http用到 open-uri 模块, 解析html用的是nokogiri, nokogiri 查找标签用的是 和css中确定标签一样的方式字符转码开始用iconv进行字符转码,
# 但执行时输出推荐字符串的encode方法,修改. 正则的匹配使用字符串的scan方法 可以返回多个结果, 直接match的话只有一个结果.
