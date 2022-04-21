{% note warning %}

The `secretName` field only supports references to certificates from {{ certificate-manager-name }} as `yc-certmgr-cert-id-<certificate ID>`. Do not enter {{ k8s }} internal secrets in this field.

{% endnote %}