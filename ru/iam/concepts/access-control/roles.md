# Роли

_Роль_ — это набор разрешений, который определяет допустимые операции с ресурсами в Яндекс.Облаке.

Роли бывают двух типов:
- _Примитивные роли_ содержат разрешения, действующие для всех типов ресурсов Яндекс.Облака. Это роли `{{ roles-admin }}`, `{{ roles-editor }}` и `{{ roles-viewer }}`.
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

## {{ resmgr-name }} {#yrm-roles}

{% include [cloud-roles](../../../_includes/cloud-roles.md) %}

## {{ iam-name }} {#iam-roles}

{% include [roles-sa-user](../../../_includes/roles-sa-user.md) %}

## {{ compute-name }} {#compute-roles}

{% include [roles-disks-user](../../../_includes/roles-disks-user.md) %}

{% include [roles-images-user](../../../_includes/roles-images-user.md) %}

## {{ dataproc-short-name }} {#mdb-roles}

{% include [mdb.dataproc.agent](../../../_includes/roles-dataproc-agent.md) %}

## {{ sf-short-name }} {#functions-roles}

{% include [serverless.functions.invoker](../../../_includes/roles-functions-invoker.md) %}

## {{ container-registry-name }} {#cr-roles}

{% include [container-registry-puller](../../../_includes/roles-container-registry-puller.md)%}

{% include [container-registry-pusher](../../../_includes/roles-container-registry-pusher.md)%}

## {{ datalens-name }} {#datalens-roles}

{% include [datalens-instances-user](../../../_includes/roles-datalens-user.md)%}
