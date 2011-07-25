ROOT = File.dirname(__FILE__)
LIB_PATH = File.join(ROOT, 'lib', 'storying')
$:.unshift LIB_PATH

%w(rubygems chance story_elements gender character storying ).each {|library| require library}
%w(bundler/setup yaml erb mustache/sinatra sinatra/base story_view thin).each {|library| require library}
Dir.entries(LIB_PATH).sort.each {|filename| require filename if filename =~ /\.rb$/ }

class StoryingWebApp < Sinatra::Base
  register Mustache::Sinatra

  TEMPLATE_PATH = ROOT + "/templates"
  VIEW_PATH = ROOT + "/views"

  TEMPLATES = Dir.glob(TEMPLATE_PATH + "/*.erb").map {|f| File.read f}
  Dir.glob(VIEW_PATH + "/*.rb").each {|filename| require filename }

  set :mustache, {
    :templates => TEMPLATE_PATH,
    :views => VIEW_PATH,
    :namespace => Storying
  }

  get '/hella' do
    mustache :simple
  end

  get '/' do
    random_template = TEMPLATES.random
    begin
      erb TEMPLATES.random, :layout => :layout
    # rescue => e
    #   raise "Error rendering #{random_template}:\n #{e}"
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end