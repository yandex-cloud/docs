Создайте файлы с параметрами для подключения к кластеру: файл для производителя и файл для потребителя.

Эти файлы имеют одинаковое содержимое, различаются только реквизиты пользователя:

```ini
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
  username="<логин_производителя_или_потребителя>" \
  password="<пароль_производителя_или_потребителя>";
security.protocol=SASL_PLAINTEXT
```
