```bash
echo "test message" | kafkacat -P \
    -b <FQDN брокера>:9091 \
    -t <имя топика> \
    -k key \
    -X security.protocol=SASL_SSL \
    -X sasl.mechanisms=SCRAM-SHA-512 \
    -X sasl.username="<логин производителя>" \
    -X sasl.password="<пароль производителя>" \
    -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexCA.crt -Z
```
