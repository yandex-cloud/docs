{% note warning %}

Поле `secretName` поддерживает только указания на сертификаты из {{ certificate-manager-name }} в формате `yc-certmgr-cert-id-<идентификатор_сертификата>`. Не указывайте в этом поле собственные секреты {{ k8s }}.

{% endnote %}