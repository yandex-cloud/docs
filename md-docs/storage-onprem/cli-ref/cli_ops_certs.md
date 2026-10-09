[Документация Yandex Cloud](../../index.md) > [On-premises Yandex Object Storage](../index.md) > Версия 26.3 > Справочник CLI (англ.) > ops > certs > Overview

# cli ops certs

Manage certificates

## Options

```
  -h, --help   help for certs
```

## Options inherited from parent commands

```
  -c, --config-dir string   path to configuration directory
      --debug               enable debug mode
      --insecure            use if console has self-signed certificate
  -p, --profile string      configuration profile
```

## See also

* [cli ops](cli_ops.md)	 — Cluster maintenance operations
* [cli ops certs generate-csr-console](cli_ops_certs_generate-csr-console.md)	 — Generate CSR for Console certificate via cert-manager
* [cli ops certs generate-csr-monitoring](cli_ops_certs_generate-csr-monitoring.md)	 — Generate CSR for Monitoring ingress certificate via cert-manager
* [cli ops certs generate-csr-private](cli_ops_certs_generate-csr-private.md)	 — Generate CSR for Private ingress certificate via cert-manager
* [cli ops certs generate-csr-s3](cli_ops_certs_generate-csr-s3.md)	 — Generate CSR for S3 certificate via cert-manager
* [cli ops certs get-csr](cli_ops_certs_get-csr.md)	 — Print PEM for a CSR by name
* [cli ops certs install-cert-console](cli_ops_certs_install-cert-console.md)	 — Install signed Console certificate returned by client CA
* [cli ops certs install-cert-monitoring](cli_ops_certs_install-cert-monitoring.md)	 — Install signed Monitoring ingress certificate returned by client CA
* [cli ops certs install-cert-private](cli_ops_certs_install-cert-private.md)	 — Install signed Private ingress certificate returned by client CA
* [cli ops certs install-cert-s3](cli_ops_certs_install-cert-s3.md)	 — Install signed S3 certificate returned by client CA
* [cli ops certs list-csr](cli_ops_certs_list-csr.md)	 — List active CSRs
* [cli ops certs upload-console](cli_ops_certs_upload-console.md)	 — Upload Console certificate
* [cli ops certs upload-monitoring](cli_ops_certs_upload-monitoring.md)	 — Upload Monitoring ingress certificate
* [cli ops certs upload-private](cli_ops_certs_upload-private.md)	 — Upload Private ingress certificate
* [cli ops certs upload-s3](cli_ops_certs_upload-s3.md)	 — Upload S3 certificate