```bash
kafkacat -C \
         -b <broker_FQDN>:9091 \
         -t <topic_name> \
         -X security.protocol=SASL_SSL \
         -X sasl.mechanism=SCRAM-SHA-512 \
         -X sasl.username="<consumer_username>" \
         -X sasl.password="<consumer_password>" \
         -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
```
