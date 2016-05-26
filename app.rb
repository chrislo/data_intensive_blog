require 'sinatra'

def event_log
  @event_log ||= Logger.new(File.join(File.dirname(__FILE__), 'log', 'event.log'))
end

def log(data)
  event_log.info(data)
end

get '/post/new' do
  erb :post_new
end

post '/post' do
  log(event: :post_created, body: params[:body])
end
