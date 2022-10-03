# Roles

A _role_  is a set of user permissions to perform operations with {{ yandex-cloud }} resources.

There are two types of roles:
* _Primitive roles_ contain permissions that apply to all types of {{ yandex-cloud }} resources. These are roles like `{{ roles-admin }}`,`{{ roles-editor }}` , and `{{ roles-viewer }}`.
* _Service roles_ contain permissions only for a specific type of resource in a particular service. The service role ID is specified in `service.resources.role` format. For example, the `{{ roles-image-user }}` role lets you use images in the {{ compute-full-name }} service.

   A service role can be assigned to the resource that the role is intended for or the resource that permissions are inherited from. For example, you can assign the `{{ roles-image-user }}` role for a folder or cloud, because images inherit permissions from them.

Currently, users aren't allowed to create new roles with a custom set of permissions.

## Primitive roles {#primitive-roles}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../../_includes/roles-admin.md) %}

## {{ alb-name }} {#alb-roles}

{% include [roles-alb-viewer](../../../_includes/roles-alb-viewer.md) %}

{% include [roles-alb-editor](../../../_includes/roles-alb-editor.md) %}

{% include [roles-alb-admin](../../../_includes/roles-alb-admin.md) %}

## {{ certificate-manager-name }} {#certificate-manager-roles}

{% include [roles-certificate-manager-admin](../../../_includes/roles-certificate-manager-admin.md) %}

{% include [roles-certificate-manager-certificates-downloader](../../../_includes/roles-certificate-manager-certificates-downloader.md) %}

{% if product == "yandex-cloud" %}

## {{ cdn-name }} {#cdn-roles}

{% include [roles-cdn-viewer](../../../_includes/roles-cdn-viewer.md) %}

{% include [roles-cdn-editor](../../../_includes/roles-cdn-editor.md) %}

{% include [roles-cdn-admin](../../../_includes/roles-cdn-admin.md) %}

{% endif %}

## {{ dns-name }} {#dns-roles}

{% include [roles-dns-viewer](../../../_includes/iam/roles/dns-viewer.md) %}

{% include [roles-dns-editor](../../../_includes/iam/roles/dns-editor.md) %}

{% include [roles-dns-admin](../../../_includes/iam/roles/dns-admin.md) %}

## {{ compute-name }} {#compute-roles}

{% include [roles-compute-admin](../../../_includes/roles-compute-admin.md) %}

{% include [roles-compute-viewer](../../../_includes/roles-compute-viewer.md) %}

{% include [roles-disks-user](../../../_includes/roles-disks-user.md) %}

{% include [roles-images-user](../../../_includes/roles-images-user.md) %}

{% include [roles-compute-operator](../../../_includes/roles-compute-operator.md) %}

## {{ container-registry-name }} {#cr-roles}

{% include [container-registry-admin](../../../_includes/roles-container-registry-admin.md) %}

{% include [container-registry-puller](../../../_includes/roles-container-registry-puller.md) %}

{% include [container-registry-pusher](../../../_includes/roles-container-registry-pusher.md) %}

## Managed databases {#mdb-roles}

{% include [mdb.admin](../../../_includes/iam/roles/mdb.admin.md) %}

{% if product == "yandex-cloud" %}

## {{ dataproc-short-name }} {#dataproc-roles}

{% include [mdb.dataproc.agent](../../../_includes/roles-dataproc-agent.md) %}

{% include [data-proc-roles](../../../_includes/data-proc/data-proc-roles.md) %}

{% endif %}

## {{ data-transfer-name }} {#data-transfer-roles}

{% include [data-transfer-viewer](../../../_includes/roles-data-transfer-viewer.md) %}

{% include [data-transfer-privateadmin](../../../_includes/roles-data-transfer-privateadmin.md) %}

{% include [data-transfer-admin](../../../_includes/roles-data-transfer-admin.md) %}

{% if product == "yandex-cloud" %}

## {{ datalens-name }} {#datalens-roles}

{% include [datalens-instances-user](../../../_includes/roles-datalens-user.md) %}

{% include [datalens-instances-admin](../../../_includes/roles-datalens-admin.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ ml-platform-name }} {#datasphere-roles}

{% include [datasphere-user](../../../_includes/roles-datasphere-user.md) %}

{% include [datasphere-admin](../../../_includes/roles-datasphere-admin.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ sf-short-name }} {#functions-roles}

{% include [serverless.functions.invoker](../../../_includes/roles-functions-invoker.md) %}

{% include [functions-roles-admin](../../../_includes/roles-functions-admin.md) %}

{% include [functions-roles-mdbproxy](../../../_includes/roles-functions-mdbproxy.md) %}

{% endif %}

## {{ iam-name }} {#iam-roles}

{% include [roles-sa-user](../../../_includes/roles-sa-user.md) %}

{% if product == "yandex-cloud" %}

## {{ iot-name }} {#iot-roles}

{% include [iot-devices-writer](../../../_includes/roles-iot-devices-writer.md) %}

{% include [iot-registries-writer](../../../_includes/roles-iot-registries-writer.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ cloud-logging-name }} {#logging}

{% include [logging-roles-viewer](../../../_includes/roles-logging-viewer.md) %}

{% include [logging-roles-editor](../../../_includes/roles-logging-editor.md) %}

{% include [logging-roles-reader](../../../_includes/roles-logging-reader.md) %}

{% include [logging-roles-writer](../../../_includes/roles-logging-writer.md) %}

{% include [logging-roles-admin](../../../_includes/roles-logging-admin.md) %}

{% endif %}

## {{ kms-name }} {#kms-roles}

{% include [kms-admin](../../../_includes/roles-kms-admin.md) %}

{% include [kms-keys-encrypterdecrypter](../../../_includes/roles-kms-keys-encrypterdecrypter.md) %}

{% include [kms-editor](../../../_includes/roles-kms-editor.md) %}

{% include [kms-viewer](../../../_includes/roles-kms-viewer.md) %}

## {{ monitoring-name }} {#monitoring-roles}

{% include [roles-monitoring-viewer](../../../_includes/roles-monitoring-viewer.md) %}

{% include [roles-monitoring-editor](../../../_includes/roles-monitoring-editor.md) %}

{% include [roles-monitoring-admin](../../../_includes/roles-monitoring-admin.md) %}

## {{ network-load-balancer-name }} {#load-balancer-roles}

{% include [roles-lb-viewer](../../../_includes/roles-lb-viewer.md) %}

{% include [roles-lb-private-admin](../../../_includes/roles-lb-private-admin.md) %}

{% include [roles-lb-admin](../../../_includes/roles-lb-admin.md) %}

## {{ objstorage-name }} {#object-storage}

{% include [storage.admin](../../../_includes/roles-storage-admin.md) %}

{% include [storage.configViewer](../../../_includes/roles-storage-config-viewer.md) %}

{% include [storage.configurer](../../../_includes/roles-storage-configurer.md) %}

{% include [storage.editor](../../../_includes/roles-storage-editor.md) %}

{% include [storage.uploader](../../../_includes/roles-storage-uploader.md) %}

{% include [storage.viewer](../../../_includes/roles-storage-viewer.md) %}

## {{ resmgr-name }} {#yrm-roles}

{% include [cloud-roles](../../../_includes/cloud-roles.md) %}

{% if product == "yandex-cloud" %}

## {{ serverless-containers-name }} {#serverless-containers}

{% include [serverless-containers-roles-viewer](../../../_includes/roles-serverless-containers-viewer.md) %}

{% include [serverless-containers-roles-invoker](../../../_includes/roles-serverless-containers-invoker.md) %}

{% include [serverless-containers-roles-editor](../../../_includes/roles-serverless-containers-editor.md) %}

{% include [serverless-containers-roles-admin](../../../_includes/roles-serverless-containers-admin.md) %}

## {{ captcha-name }} {#smartcaptcha}

{% include [smartcaptcha-viewer](../../../_includes/roles-smartcaptcha-viewer.md) %}

{% include [smartcaptcha-editor](../../../_includes/roles-smartcaptcha-editor.md) %}

{% include [smartcaptcha-admin](../../../_includes/roles-smartcaptcha-admin.md) %}

{% endif %}

## {{ vpc-name }} {#vpc-roles}

{% include [roles-vpc-viewer](../../../_includes/roles-vpc-viewer.md) %}

{% include [roles-vpc-user](../../../_includes/roles-vpc-user.md) %}

{% include [roles-vpc-private-admin](../../../_includes/roles-vpc-private-admin.md) %}

{% include [roles-vpc-public-admin](../../../_includes/roles-vpc-public-admin.md) %}

{% include [roles-vpc-sg-admin](../../../_includes/roles-vpc-sg-admin.md) %}

{% include [roles-vpc-admin](../../../_includes/roles-vpc-admin.md) %}
