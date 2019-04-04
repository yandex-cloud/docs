#### Quotas

##### Messages

Type of limit | Value
----- | -----
Number of messages that coud be sent to a standard queue | 1000 messages/s
Number of messages that coud be sent to a FIFO queue  | 100 messages/s

#### Limits

##### Queues

Type of limit | Value
----- | -----
Minimum delay of the delivery of all messages in the queue (`DelaySeconds` attribute) | 0 seconds
Maximum delay of the delivery of all messages in the queue (`DelaySeconds` attribute) | 900 seconds (15 minutes)
Maximum number of inflight messages for a standard queue | 120000
Maximum number of inflight messages for a FIFO queue | 20000
Queue name | Maximum of 80 characters: lowercase Latin letters, numbers, hyphens and underscores. Name for a FIFO queue must end with `.fifo` suffix.

##### Messages

Type of limit | Value
----- | -----
ID of the message in one group | Maximum of 80 characters: lowercase Latin letters, numbers, hyphens and underscores.
Maximum number of attributes for a message | 10
Maximum number of messages in one group | 10
Message payload | XML, JSON and unformatted text. Following Unicode symbols are supported: <ul><li>`#x9`</li> <li>`#xA`</li> <li>`#xD`</li> <li>from `#x20` to `#xD7FF`</li> <li>from `#xE000` to `#xFFFD`</li> <li>from `#x10000` to `#x10FFFF`</li></ul>
Maximum retention time for a message | 1209600 second (14 days)
Minimum retention time for a message | 60 seconds (1 minute)
Maximum delay of the delivery of a message (`DelaySeconds` attribute) | 900 seconds (15 minutes)
Minimum delay of the delivery of a message (`DelaySeconds` attribute) | 0 seconds
Maximum message size | 262144 byte (256 KB)
Minimum message size | 1 byte
Maximum message visibility timeout | 12 hours
Minimum message visibility timeout | 0 seconds

