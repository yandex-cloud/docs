```bash
kafkacat -C \
         -b <broker FQDN>:9091 \
         -t <topic name> \
         -X security.protocol=SASL_SSL \
         -X sasl.mechanisms=SCRAM-SHA-512 \
         -X sasl.username="<user name>" \
         -X sasl.password="<user password>" \
         -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
```
