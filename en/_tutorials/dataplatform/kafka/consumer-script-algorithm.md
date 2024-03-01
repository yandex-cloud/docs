The script works as follows:

1. Connect to the `messages` topic and Confluent Schema Registry.
1. In a continuous cycle, read messages sent to the `messages` topic.
1. When receiving a message, request the necessary schemas in Confluent Schema Registry to parse the message.
1. Parse binary data from the message according to the schemas for the key and value and display the result on the screen.
