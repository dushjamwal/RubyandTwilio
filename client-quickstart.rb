require 'rubygems'
require 'sinatra'
require 'twilio-ruby'

# put your default Twilio Client name here, for when a phone number isn't given
default_client = "dj"
 
get '/' do
    # Find these values at twilio.com/user/account
    account_sid = 'AC1a63d7057afd50cacfaa0ea8d36e72d5'
    auth_token = 'd6a8204c64c077101478a126b96b1348'
    capability = Twilio::Util::Capability.new account_sid, auth_token
    # Create an application sid at twilio.com/user/account/apps and use it here
    capability.allow_client_outgoing "APaee8104c163af6f2bb888e0a51658f47"
    capability.allow_client_incoming default_client
    token = capability.generate
    erb :index, :locals => {:token => token}
end

# Add a Twilio phone number or number verified with Twilio as the caller ID
caller_id = "+17206062712"

post '/voice' do
    response = Twilio::TwiML::Response.new do |r|
        # Should be your Twilio Number or a verified Caller ID
        r.Dial :callerId => caller_id do |d|
            d.Client default_client
            puts default_client
        end
    end
    response.text
end

