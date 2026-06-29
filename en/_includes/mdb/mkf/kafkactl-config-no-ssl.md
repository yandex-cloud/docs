Here is an example of the `config.yml` file:

```yaml
contexts:
  default:
    brokers:
    - <broker_FQDN>:9092
    sasl:
      enabled: true
      username: <consumer_login>
      password: <consumer_password>
      mechanism: scram-sha512
```
