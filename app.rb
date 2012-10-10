require 'rubygems'
require 'sinatra'
require 'haml'

set :haml, :format => :html5

#routes
get '/' do
  @paragraphs = generate_ipsum()
  haml :index
end

post '/custom' do  
  @paragraphs = generate_ipsum(params["paragraphs"].to_i, params["quotes"].to_i)
  haml :index
end



private
def generate_ipsum(paragraph_count = 5, quotes_per_paragraph_count = 10)
  quotes_array = []
  
  # open file and create each line as element in array
  File.open('./quotes.txt', 'r') do |file|
    file.each do |line|
      quotes_array << line.strip
    end
  end
  
  paragraph_array = []
  
  # for each paragraph pick random quote
  (1..paragraph_count).each do
    paragraph = ''
    
    (1..quotes_per_paragraph_count).each do
      paragraph << quotes_array.sample << ' '
    end
    
    paragraph_array << paragraph
  end
  
  return paragraph_array
end