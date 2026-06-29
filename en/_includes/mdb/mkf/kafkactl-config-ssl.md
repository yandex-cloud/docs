Here is an example of the `config.yml` file:

```yaml
contexts:
  default:
    brokers:
    - <broker_FQDN>:9091
    sasl:
      enabled: true
      username: <consumer_login>
      password: <consumer_password>
      mechanism: scram-sha512
    tls:
      enabled: true
      ca: /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```
