### SSL is required error {#ssl-required}

This error occurs when connecting to a {{ mos-name }} cluster as a custom installation via a {{ OS }} host's [FQDN](../../../../managed-opensearch/concepts/network.md#hostname) if **SSL** is not enabled in the endpoint settings. By default, {{ mos-name }} clusters require SSL encryption for connections via host FQDNs. 

This error may also occur if you are connecting to a custom {{ OS }} installation that requires SSL.

**Solution**:

Enable **SSL** in the endpoint settings.

For MDB clusters and other sources that use certificates issued by public CAs, you do not usually need to upload a CA certificate.

If your source uses a self-signed certificate, upload your CA certificate to the relevant field in the endpoint settings.
