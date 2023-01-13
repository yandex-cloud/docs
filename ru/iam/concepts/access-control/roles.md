# Роли

_Роль_ — это набор разрешений, который определяет допустимые операции с ресурсами в {{ yandex-cloud }}.

Роли бывают двух типов:
* _Примитивные роли_ содержат разрешения, действующие для всех типов ресурсов {{ yandex-cloud }}. Это роли `{{ roles-admin }}`, `{{ roles-editor }}` и `{{ roles-viewer }}`.
* _Сервисные роли_ содержат разрешения только для определенного типа ресурсов в указанном сервисе. Идентификатор сервисной роли указывается в формате `service.resources.role`. Например, роль `{{ roles-image-user }}` позволяет использовать образы в сервисе {{ compute-full-name }}.

  Сервисную роль можно назначить на ресурс, для которого предназначена роль, или на ресурс, от которого наследуются права доступа. Например, роль `{{ roles-image-user }}` можно назначить на каталог или облако, так как образ наследует разрешения от них.

На данный момент пользователи не могут создавать новые роли со своим набором разрешений.

## Примитивные роли {#primitive-roles}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../../_includes/roles-admin.md) %}


## {{ api-gw-full-name }} {#api-gateway-roles}

{% include [api-gateway-viewer](../../../_includes/roles-api-gateway-viewer.md) %}

{% include [api-gateway-editor](../../../_includes/roles-api-gateway-editor.md) %}

{% include [api-gateway-websocket-writer](../../../_includes/roles-api-gateway-websocket-writer.md) %}

{% include [api-gateway-admin](../../../_includes/roles-api-gateway-admin.md) %}


## {{ alb-full-name }} {#alb-roles}

{% include [roles-alb-viewer](../../../_includes/roles-alb-viewer.md) %}

{% include [roles-alb-editor](../../../_includes/roles-alb-editor.md) %}

{% include [roles-alb-admin](../../../_includes/roles-alb-admin.md) %}

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

{% include [roles-dns-viewer](../../../_includes/iam/roles/dns-viewer.md) %}

{% include [roles-dns-editor](../../../_includes/iam/roles/dns-editor.md) %}

{% include [roles-dns-admin](../../../_includes/iam/roles/dns-admin.md) %}

## {{ compute-full-name }} {#compute-roles}

{% include [roles-compute-admin](../../../_includes/roles-compute-admin.md) %}

{% include [roles-compute-viewer](../../../_includes/roles-compute-viewer.md) %}

{% include [roles-disks-user](../../../_includes/roles-disks-user.md) %}

{% include [roles-images-user](../../../_includes/roles-images-user.md) %}

{% include [roles-compute-operator](../../../_includes/roles-compute-operator.md) %}

## {{ container-registry-full-name }} {#cr-roles}

{% include [container-registry-admin](../../../_includes/roles-container-registry-admin.md) %}

{% include [container-registry-puller](../../../_includes/roles-container-registry-puller.md) %}

{% include [container-registry-pusher](../../../_includes/roles-container-registry-pusher.md) %}

## {{ managed-k8s-full-name }} {#kubernetes-roles}

{% include [k8s-admin](../../../_includes/roles-k8s-admin.md) %}

{% include [k8s-editor](../../../_includes/roles-k8s-editor.md) %}

{% include [k8s-viewer](../../../_includes/roles-k8s-viewer.md) %}

{% include [k8s-clusters-agent](../../../_includes/roles-k8s-clusters-agent.md) %}

{% include [k8s-cluster-api-cluster-admin](../../../_includes/roles-k8s-cluster-api-cluster-admin.md) %}

{% include [k8s-cluster-api-editor](../../../_includes/roles-k8s-cluster-api-editor.md) %}

{% include [k8s-cluster-api-viewer](../../../_includes/roles-k8s-cluster-api-viewer.md) %}

Подробнее см. в разделе [{#T}](../../../managed-kubernetes/security/index.md).

## Управляемые базы данных {#mdb-roles}

{% include [mdb.admin](../../../_includes/iam/roles/mdb.admin.md) %}

{% include [mdb.viewer](../../../_includes/iam/roles/mdb.viewer.md) %}

{% include [mdb.auditor](../../../_includes/iam/roles/mdb.auditor.md) %}


## {{ dataproc-full-name }} {#dataproc-roles}

{% include [mdb.dataproc.agent](../../../_includes/roles-dataproc-agent.md) %}

{% include [data-proc-roles](../../../_includes/data-proc/data-proc-roles.md) %}


## {{ data-transfer-full-name }} {#data-transfer-roles}

{% include [data-transfer-viewer](../../../_includes/roles-data-transfer-viewer.md) %}

{% include [data-transfer-privateadmin](../../../_includes/roles-data-transfer-privateadmin.md) %}

{% include [data-transfer-admin](../../../_includes/roles-data-transfer-admin.md) %}


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

{% include [kms-editor](../../../_includes/roles-kms-editor.md) %}

{% include [kms-viewer](../../../_includes/roles-kms-viewer.md) %}

## {{ mes-full-name }} {#mes-roles}

{% include [elasticsearch-viewer](../../../_includes/iam/roles/elasticsearch-viewer.md) %}

{% include [elasticsearch-editor](../../../_includes/iam/roles/elasticsearch-editor.md) %}

{% include [elasticsearch-admin](../../../_includes/iam/roles/elasticsearch-admin.md) %}

{% include [elasticsearch-auditor](../../../_includes/iam/roles/elasticsearch-auditor.md) %}


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

{% include [storage.admin](../../../_includes/roles-storage-admin.md) %}

{% include [storage.configViewer](../../../_includes/roles-storage-config-viewer.md) %}

{% include [storage.configurer](../../../_includes/roles-storage-configurer.md) %}

{% include [storage.editor](../../../_includes/roles-storage-editor.md) %}

{% include [storage.uploader](../../../_includes/roles-storage-uploader.md) %}

{% include [storage.viewer](../../../_includes/roles-storage-viewer.md) %}

## {{ resmgr-full-name }} {#yrm-roles}

{% include [cloud-roles](../../../_includes/cloud-roles.md) %}


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