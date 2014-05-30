#dashing-opsview.rb by hawk554
#Based on the Nagios plugin https://github.com/aelse/dashing-nagios by aelse

require 'rest-client'
require 'json'

#Enviroment Variables
username = '<OPSVIEW USERNAME>'
password = '<OPSVIEW PASSWORD>'
url = '<http://your.opsview.com>'

#Check URL
url_ok = RestClient.get url
if url_ok.code != 200
  print "URL for Opsview is invalid\n"
end

#Get token to use for auth
token_response = RestClient.post url+"/rest/login", :username => username, :password => password
token = JSON.parse(token_response)
auth_token = token['token']

#Change this to your desired frequency
SCHEDULER.every '30s' do
  #Get Statuses from Opsview
  resp = RestClient.get url+"/rest/status/hostgroup", 'content-type' => 'application/json', 'x-opsview-username' => username, 'x-opsview-token' => auth_token
  resp_parsed = JSON.parse(resp)
  #For some reason Opsview returns double of what is actually there
  up =  (resp_parsed['summary']['host']['up'].to_i)/2
  down =  (resp_parsed['summary']['host']['down'].to_i)/2
  #ok = (resp_parsed['summary']['service']['ok'].to_i)/2
  critical = (resp_parsed['summary']['service']['critical'].to_i)/2
  warning = (resp_parsed['summary']['service']['warning'].to_i)/2
  #Determine color of widgets
  status = down > 0 ? "red" : critical > 0 ? "red": (warning > 0 ? "yellow" : "green")
  #Send events
  send_event('opsview', {criticals: critical, warnings: warning, up: up, down: down, status: status})
end
