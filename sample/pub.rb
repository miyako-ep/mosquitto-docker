#!/usr/bin/env ruby

require 'paho-mqtt'

### Create a simple client with default attributes
client = PahoMqtt::Client.new

### Register a callback on message event to display messages
message_counter = 0
client.on_message do |message|
  puts "Message recieved on topic: #{message.topic}\n>>> #{message.payload}"
  message_counter += 1
end

### Register a callback on suback to assert the subcription
waiting_suback = true
client.on_suback do
  waiting_suback = false
  puts "Subscribed"
end

### Register a callback for puback event when receiving a puback
waiting_puback = true
client.on_puback do
  waiting_puback = false
  puts "Message Acknowledged"
end

### Register a callback for puback event when receiving a puback
waiting_pubrec = true
client.on_pubrec do
  waiting_pubrec = false
  puts "Message Received"
end

### Register a callback for puback event when receiving a puback
waiting_pubcomp = true
client.on_pubcomp do
  waiting_pubcomp = false
  puts "Message Completed"
end

### Connect to the eclipse test server on port 1883 (Unencrypted mode)
client.connect('localhost', 1883)

client.publish("/paho/ruby/test", "Hello there!", true, 2)

while waiting_puback && waiting_pubcomp do
    sleep 0.001
end

### Calling an explicit disconnect
client.disconnect

