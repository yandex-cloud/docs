```bash
kafkacat -C \
         -b <FQDN брокера>:9091 \
         -t <имя топика> \
         -X security.protocol=SASL_SSL \
         -X sasl.mechanism=SCRAM-SHA-512 \
         -X sasl.username="<логин потребителя>" \
         -X sasl.password="<пароль потребителя>" \
         -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
```
