# Роли

_Роль_ — это набор разрешений, который определяет допустимые операции с ресурсами в {{ yandex-cloud }}.

Роли бывают двух типов:
* _Примитивные роли_ содержат разрешения, действующие для всех типов ресурсов {{ yandex-cloud }}. Это роли `{{ roles-admin }}`, `{{ roles-editor }}`, `{{ roles-viewer }}` и `{{ roles-auditor }}`.
* _Сервисные роли_ содержат разрешения только для определенного типа ресурсов в указанном сервисе. Идентификатор сервисной роли указывается в формате `service.resources.role`. Например, роль `{{ roles-image-user }}` позволяет использовать образы в сервисе {{ compute-full-name }}.

  Сервисную роль можно назначить на ресурс, для которого предназначена роль, или на ресурс, от которого наследуются права доступа. Например, роль `{{ roles-image-user }}` можно назначить на каталог или облако, так как образ наследует разрешения от них.

На данный момент пользователи не могут создавать новые роли со своим набором разрешений.

## Примитивные роли {#primitive-roles}

На диаграмме показано, какие примитивные роли есть в {{ yandex-cloud }} и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![image](../../../_assets/iam/security/primitive-roles-hierarchy.svg)

#### {{ roles-auditor }} {#auditor}

{% include [roles-auditor](../../../_includes/roles-auditor.md) %}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../../_includes/roles-viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../../_includes/roles-editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../../_includes/roles-admin.md) %}

## Роль для запроса на увеличение квот {#quota-roles}

{% include [roles-quota-manager-requestOperator](../../../_includes/roles-quota-manager-requestOperator.md) %}


## {{ api-gw-full-name }} {#api-gateway-roles}

{% include [api-gateway-viewer](../../../_includes/roles-api-gateway-viewer.md) %}

{% include [api-gateway-editor](../../../_includes/roles-api-gateway-editor.md) %}

{% include [api-gateway-websocket-writer](../../../_includes/roles-api-gateway-websocket-writer.md) %}

{% include [api-gateway-admin](../../../_includes/roles-api-gateway-admin.md) %}


## {{ alb-full-name }} {#alb-roles}

{% include [roles-alb-viewer](../../../_includes/roles-alb-viewer.md) %}

{% include [roles-alb-editor](../../../_includes/roles-alb-editor.md) %}

{% include [roles-alb-admin](../../../_includes/roles-alb-admin.md) %}

## {{ at-full-name }} {#at-roles}

{% include [audit-trails-auditor](../../../_includes/iam/roles/audit-trails-auditor.md) %}

{% include [audit-trails-viewer](../../../_includes/iam/roles/audit-trails-viewer.md) %}

{% include [audit-trails-editor](../../../_includes/iam/roles/audit-trails-editor.md) %}

{% include [audit-trails-admin](../../../_includes/iam/roles/audit-trails-admin.md) %}

{% include [audit-trails-configviewer](../../../_includes/iam/roles/audit-trails-configviewer.md) %}

## {{ billing-name }} {#billing-roles}

{% include [billing-accounts-member](../../../_includes/iam/roles/billing-accounts-member.md) %}

{% include [billing-accounts-owner](../../../_includes/iam/roles/billing-accounts-owner.md) %}

{% include [billing-accounts-viewer](../../../_includes/iam/roles/billing-accounts-viewer.md) %}

{% include [billing-accounts-editor](../../../_includes/iam/roles/billing-accounts-editor.md) %}

{% include [billing-accounts-admin](../../../_includes/iam/roles/billing-accounts-admin.md) %}

{% include [billing-accounts-var-without-discounts](../../../_includes/iam/roles/billing-accounts-var-without-discounts.md) %}

{% include [billing-partners-editor](../../../_includes/iam/roles/billing-partners-editor.md) %}

## {{ certificate-manager-full-name }} {#certificate-manager-roles}

{% include [roles-certificate-manager-admin](../../../_includes/roles-certificate-manager-admin.md) %}

{% include [roles-certificate-manager-certificates-downloader](../../../_includes/roles-certificate-manager-certificates-downloader.md) %}


## {{ backup-full-name }} {#backup-roles}

{% include [roles-backup-viewer](../../../_includes/roles-backup-viewer.md) %}

{% include [roles-backup-editor](../../../_includes/roles-backup-editor.md) %}

{% include [roles-backup-admin](../../../_includes/roles-backup-admin.md) %}



## {{ cdn-full-name }} {#cdn-roles}

{% include [roles-cdn-viewer](../../../_includes/roles-cdn-viewer.md) %}

{% include [roles-cdn-editor](../../../_includes/roles-cdn-editor.md) %}

{% include [roles-cdn-admin](../../../_includes/roles-cdn-admin.md) %}


## {{ dns-full-name }} {#dns-roles}

{% include [roles-dns-auditor](../../../_includes/iam/roles/dns-auditor.md) %}

{% include [roles-dns-viewer](../../../_includes/iam/roles/dns-viewer.md) %}

{% include [roles-dns-editor](../../../_includes/iam/roles/dns-editor.md) %}

{% include [roles-dns-admin](../../../_includes/iam/roles/dns-admin.md) %}

## {{ compute-full-name }} {#compute-roles}

{% include [roles-compute-admin](../../../_includes/roles-compute-admin.md) %}

{% include [roles-compute-viewer](../../../_includes/roles-compute-viewer.md) %}

{% include [roles-disks-user](../../../_includes/roles-disks-user.md) %}

{% include [roles-images-user](../../../_includes/roles-images-user.md) %}

{% include [roles-compute-operator](../../../_includes/roles-compute-operator.md) %}

{% include [roles-compute-snapshotSchedules-editor](../../../_includes/roles-compute-snapshotSchedules-editor.md) %}

{% include [roles-compute-snapshotSchedules-viewer](../../../_includes/roles-compute-snapshotSchedules-viewer.md) %}

## {{ container-registry-full-name }} {#cr-roles}

{% include [container-registry-viewer](../../../_includes/iam/roles/container-registry-viewer.md) %}

{% include [container-registry-editor](../../../_includes/iam/roles/container-registry-editor.md) %}

{% include [container-registry-admin](../../../_includes/iam/roles/container-registry-admin.md) %}

{% include [container-registry-pusher](../../../_includes/iam/roles/container-registry-pusher.md) %}

{% include [container-registry-puller](../../../_includes/iam/roles/container-registry-puller.md) %}

{% include [container-registry-images-scanner](../../../_includes/iam/roles/container-registry-images-scanner.md) %}

## Управляемые базы данных {#mdb-roles}

{% include [mdb.admin](../../../_includes/iam/roles/mdb.admin.md) %}

{% include [mdb.viewer](../../../_includes/iam/roles/mdb.viewer.md) %}



## {{ dataproc-full-name }} {#dataproc-roles}

{% include [mdb.dataproc.agent](../../../_includes/iam/roles/dataproc-agent.md) %}

{% include [data-proc-roles](../../../_includes/iam/roles/data-proc-roles.md) %}

{% include [managed-metastore-roles](../../../_includes/iam/roles/managed-metastore-roles.md) %}


## {{ yds-full-name }} {#yds-roles}

{% include [yds-viewer](../../../_includes/iam/roles/yds-viewer.md) %}

{% include [yds-writer](../../../_includes/iam/roles/yds-writer.md) %}

{% include [yds-editor](../../../_includes/iam/roles/yds-editor.md) %}

{% include [yds-admin](../../../_includes/iam/roles/yds-admin.md) %}



## {{ data-transfer-full-name }} {#data-transfer-roles}

{% include [data-transfer-viewer](../../../_includes/iam/roles/data-transfer-viewer.md) %}

{% include [data-transfer-privateadmin](../../../_includes/iam/roles/data-transfer-privateadmin.md) %}

{% include [data-transfer-admin](../../../_includes/iam/roles/data-transfer-admin.md) %}



## {{ datalens-full-name }} {#datalens-roles}

{% include [datalens-instances-user](../../../_includes/roles-datalens-user.md) %}

{% include [datalens-instances-admin](../../../_includes/roles-datalens-admin.md) %}


## {{ ml-platform-name }} {#datasphere-roles}

{% include [datasphere-user](../../../_includes/roles-datasphere-user.md) %}

{% include [datasphere-admin](../../../_includes/roles-datasphere-admin.md) %}



## {{ sf-full-name }} {#functions-roles}

{% include [functions-roles-viewer](../../../_includes/roles-functions-viewer.md) %}

{% include [functions-roles-auditor](../../../_includes/roles-functions-auditor.md) %}

{% include [functions-roles-invoker](../../../_includes/roles-functions-invoker.md) %}

{% include [functions-roles-editor](../../../_includes/roles-functions-editor.md) %}

{% include [functions-roles-mdbproxy](../../../_includes/roles-functions-mdbproxy.md) %}

{% include [functions-roles-admin](../../../_includes/roles-functions-admin.md) %}


## {{ iam-full-name }} {#iam-roles}

{% include [roles-sa-user](../../../_includes/roles-sa-user.md) %}

{% include [roles-sa-accessKeyAdmin](../../../_includes/roles-sa-accessKeyAdmin.md) %}

{% include [roles-sa-apiKeyAdmin](../../../_includes/roles-sa-apiKeyAdmin.md) %}

{% include [roles-sa-authorizedKeyAdmin](../../../_includes/roles-sa-authorizedKeyAdmin.md) %}

{% include [roles-sa-keyAdmin](../../../_includes/roles-sa-keyAdmin.md) %}

{% include [roles-sa-tokenCreator](../../../_includes/roles-sa-tokenCreator.md) %}

{% include [roles-iam-auditor](../../../_includes/roles-iam-auditor.md) %}


## {{ iot-full-name }} {#iot-roles}

{% include [iot-devices-writer](../../../_includes/roles-iot-devices-writer.md) %}

{% include [iot-registries-writer](../../../_includes/roles-iot-registries-writer.md) %}



## {{ cloud-logging-full-name }} {#logging-roles}

{% include [logging-roles-viewer](../../../_includes/roles-logging-viewer.md) %}

{% include [logging-roles-editor](../../../_includes/roles-logging-editor.md) %}

{% include [logging-roles-reader](../../../_includes/roles-logging-reader.md) %}

{% include [logging-roles-writer](../../../_includes/roles-logging-writer.md) %}

{% include [logging-roles-admin](../../../_includes/roles-logging-admin.md) %}


## {{ kms-full-name }} {#kms-roles}

{% include [kms-admin](../../../_includes/roles-kms-admin.md) %}

{% include [kms-keys-encrypterdecrypter](../../../_includes/roles-kms-keys-encrypterdecrypter.md) %}

{% include [kms-keys-encrypter](../../../_includes/roles-kms-keys-encrypter.md) %}

{% include [kms-keys-decrypter](../../../_includes/roles-kms-keys-decrypter.md) %}

{% include [kms-editor](../../../_includes/roles-kms-editor.md) %}

{% include [kms-viewer](../../../_includes/roles-kms-viewer.md) %}

## {{ lockbox-full-name }} {#lockbox-roles}

{% include [lockbox-admin](../../../_includes/roles-lockbox-admin.md) %}

{% include [lockbox-editor](../../../_includes/roles-lockbox-editor.md) %}

{% include [lockbox-viewer](../../../_includes/roles-lockbox-viewer.md) %}

{% include [lockbox-payloadViewer](../../../_includes/roles-lockbox-payloadViewer.md) %}

## {{ mkf-full-name }} {#mkf-roles}

{% include [mkf-auditor](../../../_includes/iam/roles/mkf-auditor.md) %}

{% include [mkf-viewer](../../../_includes/iam/roles/mkf-viewer.md) %}

{% include [mkf-editor](../../../_includes/iam/roles/mkf-editor.md) %}

{% include [mkf-admin](../../../_includes/iam/roles/mkf-admin.md) %}

## {{ mch-full-name }} {#mch-roles}

{% include [mch-auditor](../../../_includes/iam/roles/mch-auditor.md) %}

{% include [mch-viewer](../../../_includes/iam/roles/mch-viewer.md) %}

{% include [mch-editor](../../../_includes/iam/roles/mch-editor.md) %}

{% include [mch-admin](../../../_includes/iam/roles/mch-admin.md) %}



## {{ mes-full-name }} {#mes-roles}

{% include [mes-auditor](../../../_includes/iam/roles/mes-auditor.md) %}

{% include [mes-viewer](../../../_includes/iam/roles/mes-viewer.md) %}

{% include [mes-editor](../../../_includes/iam/roles/mes-editor.md) %}

{% include [mes-admin](../../../_includes/iam/roles/mes-admin.md) %}

## {{ mgl-full-name }} {#mgl-roles}

{% include [gitlab-viewer](../../../_includes/iam/roles/gitlab-viewer.md) %}

{% include [gitlab-editor](../../../_includes/iam/roles/gitlab-editor.md) %}

{% include [gitlab-admin](../../../_includes/iam/roles/gitlab-admin.md) %}

## {{ mgp-full-name }} {#mgp-roles}

{% include [mgp-auditor](../../../_includes/iam/roles/mgp-auditor.md) %}

{% include [mgp-viewer](../../../_includes/iam/roles/mgp-viewer.md) %}

{% include [mgp-editor](../../../_includes/iam/roles/mgp-editor.md) %}

{% include [mgp-admin](../../../_includes/iam/roles/mgp-admin.md) %}



## {{ managed-k8s-full-name }} {#kubernetes-roles}

{% include [k8s-cluster-api-viewer](../../../_includes/iam/roles/k8s-cluster-api-viewer.md) %}

{% include [k8s-cluster-api-editor](../../../_includes/iam/roles/k8s-cluster-api-editor.md) %}

{% include [k8s-cluster-api-cluster-admin](../../../_includes/iam/roles/k8s-cluster-api-cluster-admin.md) %}

{% include [k8s-tunnel-clusters-agent](../../../_includes/iam/roles/k8s-tunnel-clusters-agent.md) %}

{% include [k8s-clusters-agent](../../../_includes/iam/roles/k8s-clusters-agent.md) %}

{% include [k8s-viewer](../../../_includes/iam/roles/k8s-viewer.md) %}

{% include [k8s-editor](../../../_includes/iam/roles/k8s-editor.md) %}

{% include [k8s-admin](../../../_includes/iam/roles/k8s-admin.md) %}

Подробнее см. в разделе [{#T}](../../../managed-kubernetes/security/index.md).



## {{ mmg-full-name }} {#mmg-roles}

{% include [mmg-auditor](../../../_includes/iam/roles/mmg-auditor.md) %}

{% include [mmg-viewer](../../../_includes/iam/roles/mmg-viewer.md) %}

{% include [mmg-editor](../../../_includes/iam/roles/mmg-editor.md) %}

{% include [mmg-admin](../../../_includes/iam/roles/mmg-admin.md) %}



## {{ mmy-full-name }} {#mmy-roles}

{% include [mmy-auditor](../../../_includes/iam/roles/mmy-auditor.md) %}

{% include [mmy-viewer](../../../_includes/iam/roles/mmy-viewer.md) %}

{% include [mmy-editor](../../../_includes/iam/roles/mmy-editor.md) %}

{% include [mmy-admin](../../../_includes/iam/roles/mmy-admin.md) %}

## {{ mos-full-name }} {#mos-roles}

{% include [mos-auditor](../../../_includes/iam/roles/mos-auditor.md) %}

{% include [mos-viewer](../../../_includes/iam/roles/mos-viewer.md) %}

{% include [mos-editor](../../../_includes/iam/roles/mos-editor.md) %}

{% include [mos-admin](../../../_includes/iam/roles/mos-admin.md) %}

## {{ mpg-full-name }} {#mpg-roles}

{% include [mpg-auditor](../../../_includes/iam/roles/mpg-auditor.md) %}

{% include [mpg-viewer](../../../_includes/iam/roles/mpg-viewer.md) %}

{% include [mpg-editor](../../../_includes/iam/roles/mpg-editor.md) %}

{% include [mpg-admin](../../../_includes/iam/roles/mpg-admin.md) %}

## {{ mrd-full-name }} {#mrd-roles}

{% include [mrd-auditor](../../../_includes/iam/roles/mrd-auditor.md) %}

{% include [mrd-viewer](../../../_includes/iam/roles/mrd-viewer.md) %}

{% include [mrd-editor](../../../_includes/iam/roles/mrd-editor.md) %}

{% include [mrd-admin](../../../_includes/iam/roles/mrd-admin.md) %}



## {{ mms-full-name }} {#mms-roles}

{% include [mms-auditor](../../../_includes/iam/roles/mms-auditor.md) %}

{% include [mms-viewer](../../../_includes/iam/roles/mms-viewer.md) %}

{% include [mms-editor](../../../_includes/iam/roles/mms-editor.md) %}

{% include [mms-admin](../../../_includes/iam/roles/mms-admin.md) %}

## {{ ydb-full-name }} {#ydb-roles}

{% include [ydb-viewer](../../../_includes/iam/roles/ydb-viewer.md) %}

{% include [ydb-editor](../../../_includes/iam/roles/ydb-editor.md) %}

{% include [ydb-admin](../../../_includes/iam/roles/ydb-admin.md) %}

## {{ message-queue-full-name }} {#ymq-roles}

{% include [roles-ymq-reader](../../../_includes/roles-ymq-reader.md) %}

{% include [roles-ymq-writer](../../../_includes/roles-ymq-writer.md) %}

{% include [roles-ymq-admin](../../../_includes/roles-ymq-admin.md) %}


## {{ monitoring-full-name }} {#monitoring-roles}

{% include [roles-monitoring-viewer](../../../_includes/roles-monitoring-viewer.md) %}

{% include [roles-monitoring-editor](../../../_includes/roles-monitoring-editor.md) %}

{% include [roles-monitoring-admin](../../../_includes/roles-monitoring-admin.md) %}

## {{ network-load-balancer-full-name }} {#load-balancer-roles}

{% include [roles-lb-viewer](../../../_includes/roles-lb-viewer.md) %}

{% include [roles-lb-private-admin](../../../_includes/roles-lb-private-admin.md) %}

{% include [roles-lb-admin](../../../_includes/roles-lb-admin.md) %}

## {{ objstorage-full-name }} {#object-storage-roles}

{% include [storage-viewer](../../../_includes/iam/roles/storage-viewer.md) %}

{% include [storage-config-viewer](../../../_includes/iam/roles/storage-config-viewer.md) %}

{% include [storage-configurer](../../../_includes/iam/roles/storage-configurer.md) %}

{% include [storage-uploader](../../../_includes/iam/roles/storage-uploader.md) %}

{% include [storage-editor](../../../_includes/iam/roles/storage-editor.md) %}

{% include [storage-admin](../../../_includes/iam/roles/storage-admin.md) %}

## {{ resmgr-full-name }} {#yrm-roles}

{% include [cloud-roles](../../../_includes/cloud-roles.md) %}


## {{ search-api-full-name }} {#search-api-roles}

{% include [roles-search-api](../../../_includes/roles-search-api-executor.md) %}



## {{ serverless-containers-full-name }} {#serverless-containers-roles}

{% include [serverless-containers-roles-viewer](../../../_includes/roles-serverless-containers-viewer.md) %}

{% include [serverless-containers-roles-auditor](../../../_includes/roles-serverless-containers-auditor.md) %}

{% include [serverless-containers-roles-invoker](../../../_includes/roles-serverless-containers-invoker.md) %}

{% include [serverless-containers-roles-editor](../../../_includes/roles-serverless-containers-editor.md) %}

{% include [serverless-containers-roles-admin](../../../_includes/roles-serverless-containers-admin.md) %}

## {{ captcha-full-name }} {#smartcaptcha-roles}

{% include [smartcaptcha-viewer](../../../_includes/roles-smartcaptcha-viewer.md) %}

{% include [smartcaptcha-editor](../../../_includes/roles-smartcaptcha-editor.md) %}

{% include [smartcaptcha-admin](../../../_includes/roles-smartcaptcha-admin.md) %}


## {{ speechkit-full-name }} {#speechkit-roles}

{% include [roles-speechkit-stt-user](../../../_includes/roles-speechkit-stt-user.md) %}

{% include [roles-speechkit-tts-user](../../../_includes/roles-speechkit-tts-user.md) %}



## {{ translate-full-name }} {#translate-roles}

{% include [roles-translate-user](../../../_includes/translate/roles-translate-user.md) %}

## {{ vision-full-name }} {#vision-roles}

{% include [roles-vision-user](../../../_includes/vision/roles-vision-user.md) %}



## {{ vpc-full-name }} {#vpc-roles}

{% include [roles-vpc-viewer](../../../_includes/roles-vpc-viewer.md) %}

{% include [roles-vpc-user](../../../_includes/roles-vpc-user.md) %}

{% include [roles-vpc-private-admin](../../../_includes/roles-vpc-private-admin.md) %}

{% include [roles-vpc-public-admin](../../../_includes/roles-vpc-public-admin.md) %}

{% include [roles-vpc-gw-editor](../../../_includes/roles-vpc-gw-editor.md) %}

{% include [roles-vpc-gw-user](../../../_includes/roles-vpc-gw-user.md) %}

{% include [roles-vpc-sg-admin](../../../_includes/roles-vpc-sg-admin.md) %}

{% include [roles-vpc-admin](../../../_includes/roles-vpc-admin.md) %}


## {{ wiki-full-name }} {#wiki-roles}

{% include [wiki-viewer](../../../_includes/iam/roles/wiki-viewer.md) %}

{% include [wiki-admin](../../../_includes/iam/roles/wiki-admin.md) %}

## {{ yq-full-name }} {#yq-roles}

{% include [yq-invoker](../../../_includes/iam/roles/yq-invoker.md) %}

{% include [yq-viewer](../../../_includes/iam/roles/yq-viewer.md) %}

{% include [yq-editor](../../../_includes/iam/roles/yq-editor.md) %}

{% include [yq-admin](../../../_includes/iam/roles/yq-admin.md) %}


## {{ yagpt-full-name }} {#yandexgpt-roles}

{% include [roles-yandexgpt-user](../../../_includes/roles-yandexgpt-user.md) %}
