Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер {{ KF }} мог использовать этот сертификат при защищенном подключении к хостам кластера. Задайте пароль в параметре `-storepass` для дополнительной защиты хранилища:

```bash
sudo keytool -importcert \
             -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt \
             -keystore ssl -storepass <пароль хранилища сертификатов, не короче 6 символов> \
             --noprompt
```
