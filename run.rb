#!/usr/bin/env ruby
# coding:utf-8

require 'open-uri'
require 'nokogiri'
require 'json'
require 'pp'

$msmth_url = 'http://m.newsmth.net'

# get html
doc = Nokogiri::HTML(open($msmth_url).read) # m.newsmth.net is utf-8

top10 = Array.new
doc.css('body div#wraper div#m_main ul.slist li').each do |item|
  # 跳过"十大热门话题"title
  next if item['class'] == 'f'
  url = $msmth_url + item.children[1]['href']
  title = item.text
  top10 <<  {
    "arg" => url,
    "title" => title,
    "valid" => true,
    "quicklookurl" => url,
    "icon" => {"path"=>"workflow_openurl.png"},
  }
  # pp item
end

result = Hash.new
result['items'] = top10
puts result.to_json
