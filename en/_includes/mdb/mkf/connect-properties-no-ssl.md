Create files with cluster connection parameters: a file for the producer and a file for the consumer.

The files have the same content, only the user details are different:

```ini
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
  username="<producer_or_consumer_login>" \
  password="<producer_or_consumer_password>";
security.protocol=SASL_PLAINTEXT
```
