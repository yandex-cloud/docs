# Роли

_Роль_ — это набор разрешений, который определяет допустимые операции с ресурсами в {{ yandex-cloud }}.

Роли бывают двух типов:
- _Примитивные роли_ содержат разрешения, действующие для всех типов ресурсов {{ yandex-cloud }}. Это роли `{{ roles-admin }}`, `{{ roles-editor }}` и `{{ roles-viewer }}`.
- _Сервисные роли_ содержат разрешения только для определенного типа ресурсов в указанном сервисе. Идентификатор сервисной роли указывается в формате `service.resources.role`. Например, роль `{{ roles-image-user }}` позволяет использовать образы в сервисе Yandex Compute Cloud.

    Сервисную роль можно назначить на ресурс, для которого предназначена роль, или на ресурс, от которого наследуются права доступа. Например, роль `{{ roles-image-user }}` можно назначить на каталог или облако, так как образ наследует разрешения от них.

На данный момент пользователи не могут создавать новые роли со своим набором разрешений.

## Примитивные роли {#primitive-roles}

### {{ roles-viewer }} {#viewer}

Роль `{{ roles-viewer }}` дает разрешения на чтение к ресурсам.

Например, роль `{{ roles-viewer }}` позволяет выполнять следующие операции:
- Просмотр информации о ресурсе.
- Получение списка вложенных ресурсов, например списка виртуальных машин в каталоге.
- Просмотр списка операций с ресурсом.

### {{ roles-editor }} {#editor}

Роль `{{ roles-editor }}` дает разрешения на все операции для управления ресурсом, кроме назначения ролей другим пользователям. Роль `{{ roles-editor }}` включает все разрешения, которые дает роль `{{ roles-viewer }}`.

Например, роль `{{ roles-editor }}` позволяет выполнять следующие операции:
- Создание ресурса;
- Обновление ресурса;
- Удаление ресурса.

### {{ roles-admin }} {#admin}

Роль `{{ roles-admin }}` дает все разрешения для управления ресурсом, включая назначение ролей другим пользователям. Можно назначать любые роли за исключением `{{ roles-cloud-owner }}`.

Роль `{{ roles-admin }}` включает все разрешения, которые дает роль `{{ roles-editor }}`.

Например, роль `{{ roles-admin }}` позволяет выполнять следующие операции:
- Установить права доступа к ресурсу;
- Изменить права доступа к ресурсу.

## {{ certificate-manager-name }} {#certificate-manager-roles}

{% include [roles-certificate-manager-admin](../../../_includes/roles-certificate-manager-admin.md) %}

{% include [roles-certificate-manager-certificates-downloader](../../../_includes/roles-certificate-manager-certificates-downloader.md) %}

## {{ compute-name }} {#compute-roles}

{% include [roles-compute-admin](../../../_includes/roles-compute-admin.md) %}

{% include [roles-disks-user](../../../_includes/roles-disks-user.md) %}

{% include [roles-images-user](../../../_includes/roles-images-user.md) %}

## {{ container-registry-name }} {#cr-roles}

{% include [container-registry-admin](../../../_includes/roles-container-registry-admin.md)%}

{% include [container-registry-puller](../../../_includes/roles-container-registry-puller.md)%}

{% include [container-registry-pusher](../../../_includes/roles-container-registry-pusher.md)%}

## {{ dataproc-short-name }} {#mdb-roles}

{% include [mdb.dataproc.agent](../../../_includes/roles-dataproc-agent.md) %}

## {{ data-transfer-name }} {#data-transfer-roles}

{% include [data-transfer-viewer](../../../_includes/roles-data-transfer-viewer.md)%}

## {{ datalens-name }} {#datalens-roles}

{% include [datalens-instances-user](../../../_includes/roles-datalens-user.md)%}

{% include [datalens-instances-admin](../../../_includes/roles-datalens-admin.md)%}

## {{ ml-platform-name }} {#datasphere-roles}

{% include [datasphere-user](../../../_includes/roles-datasphere-user.md)%}

{% include [datasphere-admin](../../../_includes/roles-datasphere-admin.md)%}

## {{ sf-short-name }} {#functions-roles}

{% include [serverless.functions.invoker](../../../_includes/roles-functions-invoker.md) %}

## {{ iam-name }} {#iam-roles}

{% include [roles-sa-user](../../../_includes/roles-sa-user.md) %}

## {{ iot-name }} {#iot-roles}

{% include [iot-devices-writer](../../../_includes/roles-iot-devices-writer.md) %}

{% include [iot-registries-writer](../../../_includes/roles-iot-registries-writer.md) %}

## {{ kms-name }} {#kms-roles}

{% include [kms-admin](../../../_includes/roles-kms-admin.md)%}

{% include [kms-keys-encrypterdecrypter](../../../_includes/roles-kms-keys-encrypterdecrypter.md)%}

## {{ network-load-balancer-name }} {#load-balancer-roles}

{% include [roles-lb-viewer](../../../_includes/roles-lb-viewer.md) %}

{% include [roles-lb-private-admin](../../../_includes/roles-lb-private-admin.md) %}

{% include [roles-lb-admin](../../../_includes/roles-lb-admin.md) %}

## {{ objstorage-name }} {#object storage}

{% include [storage.admin](../../../_includes/roles-storage-admin.md) %}

{% include [storage.configViewer](../../../_includes/roles-storage-config-viewer.md) %}

{% include [storage.configurer](../../../_includes/roles-storage-configurer.md) %}

{% include [storage.editor](../../../_includes/roles-storage-editor.md) %}

{% include [storage.uploader](../../../_includes/roles-storage-uploader.md) %}

{% include [storage.viewer](../../../_includes/roles-storage-viewer.md) %}

## {{ resmgr-name }} {#yrm-roles}

{% include [cloud-roles](../../../_includes/cloud-roles.md) %}

## {{ vpc-name }} {#vpc-roles}

{% include [roles-vpc-viewer](../../../_includes/roles-vpc-viewer.md) %}

{% include [roles-vpc-user](../../../_includes/roles-vpc-user.md) %}

{% include [roles-vpc-private-admin](../../../_includes/roles-vpc-private-admin.md) %}

{% include [roles-vpc-public-admin](../../../_includes/roles-vpc-public-admin.md) %}

{% include [roles-vpc-sg-admin](../../../_includes/roles-vpc-sg-admin.md) %}

{% include [roles-vpc-admin](../../../_includes/roles-vpc-admin.md) %}
