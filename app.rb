require 'sinatra'
require 'json'

def event_log
  @event_log ||= Logger.new(File.join(File.dirname(__FILE__), 'log', 'event.log'))

  @event_log.formatter = proc do |severity, datetime, progname, msg|
    {time: datetime}.merge(msg).to_json + "\n"
  end

  @event_log
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
