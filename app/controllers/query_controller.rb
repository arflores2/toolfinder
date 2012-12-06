require 'httpclient'
require 'hpricot'

class QueryController < ApplicationController
  def list

    client = HTTPClient.new
    git = client.get_content("https://api.github.com/legacy/repos/search/bootstrap")
    @git_results = JSON.parse git

    google_code_raw = Hpricot(open("http://code.google.com/hosting/search?q=bootstrap").read)

    @google_code_results = []
    google_code_raw.search("/html/body//div[@id='serp']/table").each do |table|
     @google_code_results << table.search("tr/td:nth(1)/a")
    end
  end
end
