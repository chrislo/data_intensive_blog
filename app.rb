require 'sinatra'
require 'json'

def logfile
  File.join(File.dirname(__FILE__), 'log', 'event.log')
end

def event_log
  @event_log ||= Logger.new(logfile)

  @event_log.formatter = proc do |severity, datetime, progname, msg|
    {time: datetime}.merge(msg).to_json + "\n"
  end

  @event_log
end

def log(data)
  event_log.info(data)
end

def generate_materialized_views
  File.open("./views/homepage.erb", "wb") do |view|
    view.puts "<h1>My blog</h1>"
    File.foreach(logfile) do |line|
      begin
        event = JSON.parse(line)
        view.puts "<h2>#{event["body"]}</h2>"
      rescue JSON::ParserError
      end
    end
  end
end

get '/' do
  generate_materialized_views
  erb :homepage
end

get '/post/new' do
  erb :post_new
end

post '/post' do
  log(event: :post_created, body: params[:body])
end
