### Error connecting to a user database {#failed-to-connect}

Error message (for {{ MY }}):

```text
failed to initialize LocalWorker:
failed to create source: unable to create *mysql.MysqlSource:
unable to create new mysql source: failed to create canal: failed to check bin log row format:
failed to connect to the database: handleAuthResult: ERROR 1045 (28000):
Access denied for user '<username>'@'<IP_address>' (using password: YES)
```

The error occurs if the CA certificate is not specified in the endpoint parameters for the custom DB installation.

This certificate is required for a secure TLS connection between {{ data-transfer-name }} and the user DB server. When connecting, {{ data-transfer-name }} verifies the certificate is valid and issued by a trusted certification authority (CA). Without the certificate, the connection will fail.


**Solution**: Specify the CA certificate in the endpoint parameters for the custom DB installation.