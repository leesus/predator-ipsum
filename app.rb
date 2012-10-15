require 'rubygems'
require 'sinatra'
require 'haml'

enable :run

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public_folder, 'public'
set :haml, :format => :html5

#routes
get '/' do
  @paragraphs = generate_ipsum()
  haml :index
end

post '/custom' do
  paras = params["paragraphs"].to_i
  quotes = params["quotes"].to_i
  ipsum = !params["include_ipsum"].nil?
  safe_for_work = !params["safe_for_work"].nil?
  @paragraphs = generate_ipsum(paras, quotes, ipsum, safe_for_work)
  haml :index, :layout => (request.xhr? ? false : :layout)
end



private
def generate_ipsum(paragraph_count = 1, quotes_per_paragraph_count = 10, include_ipsum = false, safe_for_work = false)
  quotes_array = []
  profanity = /\bass|\bfuck|\bpussy|\bbitch|\bcunt|\btwat|\bbullshit|\bbastard|\bmotherfucker|\bfaggots/i
  
  # open file and create each line as element in array
  File.open('./quotes.txt', 'r') do |file|
    file.each do |line|      
      if safe_for_work && (profanity.match(line))
        next
      else
        quotes_array << line.strip
      end
    end
  end
  
  if include_ipsum
    File.open('./lorem.txt', 'r') do |file|
      file.each do |line|
        quotes_array << line.strip
      end
    end
  end
  
  paragraph_array = []
  
  # for each paragraph pick random quote
  (1..paragraph_count).each do
    paragraph = ''
    
    (1..quotes_per_paragraph_count).each do
      sample = quotes_array.sample
      while paragraph.include? sample
        sample = quotes_array.sample
      end
      paragraph << sample << ' '
    end
    
    paragraph_array << paragraph
  end
  
  return paragraph_array
end