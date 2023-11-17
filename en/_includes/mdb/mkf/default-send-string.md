```bash
echo "test message" | kafkacat -P \
    -b <broker_FQDN>:9091 \
    -t <topic_name> \
    -k key \
    -X security.protocol=SASL_SSL \
    -X sasl.mechanism=SCRAM-SHA-512 \
    -X sasl.username="<producer_login>" \
    -X sasl.password="<producer_password>" \
    -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
```
