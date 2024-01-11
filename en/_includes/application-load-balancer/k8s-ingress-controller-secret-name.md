{% note warning %}

The `secretName` field only supports references to certificates from {{ certificate-manager-name }} in `yc-certmgr-cert-id-<certificate_ID>` format. Do not enter {{ k8s }} internal secrets in this field.

{% endnote %}