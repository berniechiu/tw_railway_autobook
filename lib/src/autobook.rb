# encoding: utf-8
require "mechanize"

stations = {
  :"臺北" => 1008,
  :"花蓮" => 1715
}

depart = "臺北"
destination = "花蓮"
date = "2016/08/01"
time = "0000"
id = ARGV[0] || ""

agent = Mechanize.new
agent.get("http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=0&searchdate=#{date}&fromcity=&tocity=&fromstation=#{stations[depart.to_sym]}&tostation=#{stations[destination.to_sym]}&trainclass=2&timetype=1&fromtime=#{time}&totime=2359") do |page|
  book_page = page.links_with(href: /Ticketing/).first.click
  book_page.form.person_id = id
  check_auth = book_page.form.submit
  check_auth.form.randInput = "??????" # Still working on it
  p check_auth.form.submit
end
