```bash
kafkacat -C \
         -b <FQDN_брокера>:9091 \
         -t <имя_топика> \
         -X security.protocol=SASL_SSL \
         -X sasl.mechanism=SCRAM-SHA-512 \
         -X sasl.username="<логин_потребителя>" \
         -X sasl.password="<пароль_потребителя>" \
         -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
```
