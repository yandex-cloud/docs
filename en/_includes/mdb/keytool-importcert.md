Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ KF }} driver can use this certificate for secure connections to the cluster hosts. Set a password of at least 6 characters using the `-storepass` parameter for additional storage protection:

```bash
sudo keytool -importcert \
             -alias {{ crt-alias }} -file {{ crt-local-dir }}{{ crt-local-file }} \
             -keystore ssl -storepass <certificate_store_password> \
             --noprompt
```

