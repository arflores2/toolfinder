class SearchController < ApplicationController

  def index
    @searching = ''
    @git_results = Hash.new
    @google_code_results = []

    if params['search']
      @searching = params['search'].gsub(' ', '+')
      client = HTTPClient.new
      git = client.get_content("https://api.github.com/legacy/repos/search/#{@searching}")
      @git_results = JSON.parse git

      google_code_raw = Hpricot(open("http://code.google.com/hosting/search?q=#{@searching}").read)

      google_code_raw.search("/html/body//div[@id='serp']/table").each do |table|
       @google_code_results << table.search("tr/td:nth(1)/a")
      end
    else
      @git_results['repositories'] = []
    end
  end

end
