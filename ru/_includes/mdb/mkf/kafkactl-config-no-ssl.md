Пример файла `config.yml`:

```yaml
contexts:
  default:
    brokers:
    - <FQDN_брокера>:9092
    sasl:
      enabled: true
      username: <логин_потребителя>
      password: <пароль_потребителя>
      mechanism: scram-sha512
```
