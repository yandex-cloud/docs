Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ KF }} driver can use this certificate for secure connections to the cluster hosts. Set the password using the `-storepass` parameter for additional storage protection:

```bash
sudo keytool -importcert \
             -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt \
             -keystore ssl -storepass <certificate store password, at least 6 characters> \
             --noprompt
```

