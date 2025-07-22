### SSL is required error

This error occurs when connecting to a {{ mch-name }} cluster as a custom installation via a {{ CH }} host's [FQDN](../../../../managed-clickhouse/concepts/network.md#hostname) if **SSL** is not enabled in the endpoint settings. By default, {{ mch-name }} clusters require SSL encryption for connections via host FQDNs. 

This error may also occur if you are connecting to a custom {{ CH }} installation that requires SSL.

**Solution**:

Enable **SSL** in the endpoint settings.

For MDB clusters and other sources that use certificates issued by public CAs, you do not usually need to upload a CA certificate.

If your source uses a self-signed certificate, upload your CA certificate to the relevant field in the endpoint settings.
