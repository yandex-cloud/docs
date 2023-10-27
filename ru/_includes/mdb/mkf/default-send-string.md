```bash
echo "test message" | kafkacat -P \
    -b <FQDN_брокера>:9091 \
    -t <имя_топика> \
    -k key \
    -X security.protocol=SASL_SSL \
    -X sasl.mechanism=SCRAM-SHA-512 \
    -X sasl.username="<логин_производителя>" \
    -X sasl.password="<пароль_производителя>" \
    -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
```
