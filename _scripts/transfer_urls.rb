require 'rubygems'
require 'rest_client'
require 'json'

DISQUS_BASE = 'http://disqus.com/api/'
DISQUS = RestClient::Resource.new DISQUS_BASE

SOURCE_URL = 'http://antagomir.dev/opencomp/'
TARGET_URL = 'http://antagomir.name/opencomp/'

THREADS = {
10211725 => 'http://antagomir.name/opencomp/behold-jensens-inequality.html',
10211748 => 'http://antagomir.name/opencomp/feed-bag-a-simple-rss-archiver.html',
10211737 => 'http://antagomir.name/opencomp/visualising-reading.html',
10211738 => 'http://antagomir.name/opencomp/snuck-flied-and-wedded.html',
10211739 => 'http://antagomir.name/opencomp/super-crunchers.html',
10211728 => 'http://antagomir.name/opencomp/colt-2008-highlights.html',
10211784 => 'http://antagomir.name/opencomp/staying-organised-with-citeulike-and-bibdesk.html',
10211740 => 'http://antagomir.name/opencomp/constructive-and-classical-mathematics.html',
10211730 => 'http://antagomir.name/opencomp/the-earth-is-round.html',
10211753 => 'http://antagomir.name/opencomp/information-divergence-and-risk.html',
10211742 => 'http://antagomir.name/opencomp/ml-and-stats-people-on-twitter.html',
10211720 => 'http://antagomir.name/opencomp/a-meta-index-of-data-sets.html',
10211710 => 'http://antagomir.name/opencomp/introducing-inductio-ex-machina.html',
10211755 => 'http://antagomir.name/opencomp/artificial-ai.html',
10211733 => 'http://antagomir.name/opencomp/machine-learning-summer-school-2009.html',
10211711 => 'http://antagomir.name/opencomp/clarity-and-mathematics.html',
10211713 => 'http://antagomir.name/opencomp/a-cute-convexity-result.html',
}

# Gets the first forum key associated with USER_KEY
def forum_key
  forum_list = get('get_forum_list', :user_api_key => USER_KEY)
  forum_id = forum_list[0]['id']
  get('get_forum_api_key', :user_api_key => USER_KEY, :forum_id => forum_id)  
end

# Encapsulates request, JSON parsing and error checking a REST call to Disqus
def get(command, args)
  path = command + '?' + args.map {|k,v| "#{k}=#{v}"}.join('&')
  response = JSON.parse( DISQUS[path].get )
  raise "Bad response to #{path}" unless response['succeeded']
  response['message']
end

def threads
  thread_list = get('get_thread_list', :forum_api_key => FORUM_KEY)
end

# Set the URL of the Disqus thread to the given value
def update(thread_id, url)
  data = {
    :forum_api_key => FORUM_KEY,
    :thread_id => thread_id,
    :url => url
  }

  puts "Updating thread #{thread_id} with URL = #{url}"
  response = JSON.parse( DISQUS['update_thread'].post(data) )
end

USER_KEY = ENV['DISQUS_KEY']
FORUM_KEY = forum_key


# Check everything worked
threads.each do |t|
  url = THREADS[t['id'].to_i]
  next if url.nil?
  puts "Thread #{t['id']} has #{url}"
end
