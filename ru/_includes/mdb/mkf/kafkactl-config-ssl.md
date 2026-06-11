Пример файла `config.yml`:

```yaml
contexts:
  default:
    brokers:
    - <FQDN_брокера>:9091
    sasl:
      enabled: true
      username: <логин_потребителя>
      password: <пароль_потребителя>
      mechanism: scram-sha512
    tls:
      enabled: true
      ca: /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```
