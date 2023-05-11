```bash
echo "test message" | kafkacat -P \
    -b <FQDN брокера>:9091 \
    -t <имя топика> \
    -k key \
    -X security.protocol=SASL_SSL \
    -X sasl.mechanism=SCRAM-SHA-512 \
    -X sasl.username="<логин производителя>" \
    -X sasl.password="<пароль производителя>" \
    -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
```
