Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер {{ KF }} мог использовать этот сертификат при защищенном подключении к хостам кластера. Задайте пароль не короче 6 символов в параметре `-storepass` для дополнительной защиты хранилища:

```bash
sudo keytool -importcert \
             -alias {{ crt-alias }} -file {{ crt-local-dir }}{{ crt-local-file }} \
             -keystore ssl -storepass <пароль_хранилища_сертификатов> \
             --noprompt
```
