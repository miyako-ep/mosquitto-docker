#!/usr/bin/env ruby

require 'paho-mqtt'
require 'pp'

### Create a simple client with default attributes
client = PahoMqtt::Client.new

### Register a callback on message event to display messages
message_counter = 0
client.on_message do |message|
  puts "Message recieved on topic: #{message.topic}\n>>> #{message.payload}"
  pp message
  message_counter += 1
end

### Register a callback on suback to assert the subcription
waiting_suback = true
client.on_suback do
  waiting_suback = false
  puts "Subscribed"
end

### Connect to the eclipse test server on port 1883 (Unencrypted mode)
client.connect('localhost', 1883)

### Subscribe to a topic
client.subscribe(['/paho/ruby/test', 1])

loop do
  sleep(1.0)
end

### Calling an explicit disconnect
client.disconnect

