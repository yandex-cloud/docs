Create two configuration files to connect to the cluster: one for the producer and one for the consumer.

These files have the same content and differ only in user credentials:

```ini
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
  username="<producer_or_consumer_login>" \
  password="<producer_or_consumer_password>";
security.protocol=SASL_PLAINTEXT
```
