Чтобы найти события по ресурсам и операциям, [откройте аудитные логи в {{ monium-name }}](../../../audit-trails/tutorials/search-monium.md) и выберите период поиска. [Перейдите в текстовый режим](../../../audit-trails/tutorials/search-cloud-logging.md) и выполните нужный запрос.

В каждом запросе замените `<идентификатор_каталога_трейла>` на идентификатор каталога, в котором находится трейл. Чтобы отобрать события, доставленные конкретным трейлом, добавьте условие `trail_id=="<идентификатор_трейла>"`.

Для логов в бакете {{ objstorage-name }} используйте [примеры поиска с помощью jq](../../../audit-trails/tutorials/search-bucket.md#search).

Выберите сценарий поиска.

**Инфраструктура и сеть**

* [{{ compute-full-name }}](#compute)
    * [Основные операции с виртуальной машиной](#any-actions-vm)
    * [Добавление дополнительного интерфейса к виртуальной машине](#attach-additional-interface-vm)
    * [Добавление доступа к серийной консоли виртуальной машины](#add-access-serial-console-vm)
    * [Создание или изменение виртуальной машины с включенным получением токена через AWS IMDSv1](#create-vm-aws-imdsv1)
* [{{ vpc-full-name }}](#vpc)
    * [Любые действия с определенного IP-адреса](#any-actions-ip)
    * [Добавление публичного IP-адреса к виртуальной машине](#address-attached)
    * [Создание или изменение группы безопасности](#create-security-group)

**Мониторинг и управление ресурсами**

* [{{ org-full-name }}](#organization)
    * [Удаление каталога](#delete-folder)
    * [Создание федерации](#create-federation)
    * [Изменение федерации](#update-federation)
    * [Добавление сертификата в федерацию](#create-certificate)
    * [Обнаружение облачного секрета в открытом доступе](#detect-leaked-credential)

**Контейнеры**

* [{{ managed-k8s-full-name }}](#k8s)
    * [Создание кластера с публичным IPv4-адресом мастера](#create-k8s-with-public-ip-for-master)
    * [Создание или изменение кластера без группы безопасности для мастера](#create-k8s-without-security-group-for-master)
    * [Создание или изменение кластера без автоматического обновления мастера](#create-k8s-without-autoupgrade-for-master)
    * [Создание кластера без ключа KMS для шифрования секретов](#create-k8s-without-etcd-encryption)
    * [Создание кластера без контроллера сетевых политик](#create-k8s-without-network-policy)
    * [Создание группы узлов с публичными IPv4-адресами](#create-k8s-with-public-ip-for-node-group)
    * [Создание или изменение группы узлов без автоматического обновления](#create-k8s-without-autoupgrade-for-node-group)
* [{{ container-registry-full-name }}](#container-registry)
    * [Обнаружение критических уязвимостей при сканировании образа](#detect-critical-vulnerabilities)

**Платформа данных**

* [{{ objstorage-full-name }}](#object-storage)
    * [Изменение политики доступа к бакету](#update-bucket-policy)
    * [Открытие публичного доступа при создании или изменении бакета](#public-access-bucket)
* [{{ mpg-full-name }} и {{ mmy-full-name }}](#mdb)
    * [Создание или изменение пользователя базы данных](#create-user)

**Безопасность**

* [{{ kms-full-name }}](#kms)
    * [Изменение ролей для KMS-ключей](#update-key-access-bindings)
* [{{ iam-full-name }}](#iam)
    * [Действия конкретного пользователя за период времени](#any-actions-user)
    * [Создание любых ключей для сервисных аккаунтов](#create-sa-keys)
    * [Назначение примитивных привилегированных ролей на ресурсы](#assigning-primitive-privileged-roles)
* [{{ lockbox-full-name }}](#lockbox)
    * [Изменение ролей для секретов](#update-secret-access-bindings)
    * [Чтение секрета](#read-secret)

**Поиск ошибок**

[Поиск ошибок доступа](#permission-denied)

## Инфраструктура и сеть {#infrastructure-and-network}

### {{ compute-full-name }} {#compute}

#### Основные операции с виртуальной машиной {#any-actions-vm}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Укажите идентификатор виртуальной машины. Запрос отбирает события создания, изменения, запуска, остановки, перезапуска и удаления.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.compute.CreateInstance|{{ at-event-prefix }}.audit.compute.UpdateInstance|{{ at-event-prefix }}.audit.compute.StartInstance|{{ at-event-prefix }}.audit.compute.StopInstance|{{ at-event-prefix }}.audit.compute.RestartInstance|{{ at-event-prefix }}.audit.compute.DeleteInstance", meta.details.instance_id=="<идентификатор_виртуальной_машины>"}
    ```

    В найденной записи проверьте тип операции в `meta.event_type` и идентификатор пользователя или сервисного аккаунта в `meta.authentication.subject_id`.

{% endlist %}

#### Добавление дополнительного интерфейса к виртуальной машине {#attach-additional-interface-vm}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.compute.AttachInstanceNetworkInterface"}
    ```

{% endlist %}

#### Добавление доступа к серийной консоли виртуальной машины {#add-access-serial-console-vm}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Если в записи есть поле `metadata_serial_port_enable`, отберите операции со значением `1`.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.compute.CreateInstance|{{ at-event-prefix }}.audit.compute.UpdateInstance", meta.details.metadata_serial_port_enable=="1"}
    ```

    Если в записи сохранены только имена ключей метаданных, найдите события с ключом `serial-port-enable`.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.compute.CreateInstance|{{ at-event-prefix }}.audit.compute.UpdateInstance", meta.details.metadata_keys=*'"serial-port-enable"'}
    ```

    Текущее состояние доступа можно проверить в метаданных ВМ. Значение `serial-port-enable=1` означает, что доступ включен.

{% endlist %}

#### Создание или изменение виртуальной машины с включенным получением токена через AWS IMDSv1 {#create-vm-aws-imdsv1}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.compute.CreateInstance|{{ at-event-prefix }}.audit.compute.UpdateInstance", meta.details.metadata_options.aws_v1_http_token=="ENABLED"}
    ```

{% endlist %}

### {{ vpc-full-name }} {#vpc}

#### Любые действия с определенного IP-адреса {#any-actions-ip}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.request_metadata.remote_address=="<ip_адрес>"}
    ```

{% endlist %}

#### Добавление публичного IP-адреса к виртуальной машине {#address-attached}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.network.AddressAttached", meta.details.type=="EXTERNAL", meta.details.instance_id="*"}
    ```

{% endlist %}

#### Создание или изменение группы безопасности {#create-security-group}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.network.CreateSecurityGroup|{{ at-event-prefix }}.audit.network.UpdateSecurityGroup"}
    ```

{% endlist %}

## Мониторинг и управление ресурсами {#monitoring-and-resource-management}

### {{ org-full-name }} {#organization}

#### Удаление каталога {#delete-folder}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Для поиска по идентификатору каталога используйте поле `meta.details.folder_id`.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.resourcemanager.DeleteFolder", meta.details.folder_id=="<идентификатор_каталога>"}
    ```

    Для поиска по имени каталога используйте поле `meta.details.folder_name`.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.resourcemanager.DeleteFolder", meta.details.folder_name=="<имя_каталога>"}
    ```

    Чтобы узнать, кто удалил каталог, проверьте идентификатор в `meta.authentication.subject_id`. Если в событии передано имя, оно указано в `meta.authentication.subject_name`.

{% endlist %}

#### Создание федерации {#create-federation}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.organizationmanager.saml.CreateFederation"}
    ```

{% endlist %}

#### Изменение федерации {#update-federation}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.organizationmanager.saml.UpdateFederation"}
    ```

{% endlist %}

#### Добавление сертификата в федерацию {#create-certificate}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.organizationmanager.saml.CreateCertificate"}
    ```

{% endlist %}

#### Обнаружение облачного секрета в открытом доступе {#detect-leaked-credential}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.iam.DetectLeakedCredential|{{ at-event-prefix }}.audit.organizationmanager.DetectLeakedCredential"}
    ```

{% endlist %}

## Контейнеры {#containers}

### {{ managed-k8s-full-name }} {#k8s}

#### Создание кластера с публичным IPv4-адресом мастера {#create-k8s-with-public-ip-for-master}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Отберите события успешного создания кластера, в которых указан внешний IPv4-эндпоинт мастера.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.k8s.CreateCluster", meta.event_status=="DONE", meta.details.master.endpoints.external_v4_endpoint="*"}
    ```

{% endlist %}

#### Создание или изменение кластера без группы безопасности для мастера {#create-k8s-without-security-group-for-master}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Отберите события, в которых список групп безопасности мастера отсутствует.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.k8s.CreateCluster|{{ at-event-prefix }}.audit.k8s.UpdateCluster", meta.event_status=="DONE", meta.details.cluster_id="*", meta.details.master.security_group_ids="-"}
    ```

    Если пустой список записан как JSON-строка, используйте другой запрос.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.k8s.CreateCluster|{{ at-event-prefix }}.audit.k8s.UpdateCluster", meta.event_status=="DONE", meta.details.cluster_id="*", meta.details.master.security_group_ids=~'^\[[[:space:]]*\]$'}
    ```

    Проверьте настройки групп безопасности мастера у найденных кластеров.

{% endlist %}

#### Создание или изменение кластера без автоматического обновления мастера {#create-k8s-without-autoupgrade-for-master}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Отберите события, в которых автоматическое обновление мастера выключено или поле `auto_upgrade` отсутствует.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.k8s.CreateCluster|{{ at-event-prefix }}.audit.k8s.UpdateCluster", meta.event_status=="DONE", meta.details.cluster_id="*", meta.details.master.maintenance_policy.auto_upgrade="false|-"}
    ```

    Если поле отсутствует, проверьте политику обновлений кластера.

{% endlist %}

#### Создание кластера без ключа KMS для шифрования секретов {#create-k8s-without-etcd-encryption}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Отберите события успешного создания кластера, в которых отсутствует идентификатор ключа шифрования секретов.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.k8s.CreateCluster", meta.event_status=="DONE", meta.details.cluster_id="*", meta.details.kms_provider.key_id="-"}
    ```

{% endlist %}

#### Создание кластера без контроллера сетевых политик {#create-k8s-without-network-policy}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Отберите события успешного создания кластера, в которых отсутствуют поставщик сетевых политик и режим маршрутизации Cilium.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.k8s.CreateCluster", meta.event_status=="DONE", meta.details.cluster_id="*", meta.details.network_policy.provider="-", meta.details.cilium.routing_mode="-"}
    ```

    Чтобы подтвердить результат, проверьте [настройки сетевых политик](../../../managed-kubernetes/concepts/network-policy.md) кластера.

{% endlist %}

#### Создание группы узлов с публичными IPv4-адресами {#create-k8s-with-public-ip-for-node-group}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Найдите события создания группы узлов с настройками публичного IPv4-адреса в шаблоне узлов.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.k8s.CreateNodeGroup", meta.event_status=="DONE", meta.details.node_template.v4_address_spec.one_to_one_nat_spec.ip_version="*"}
    ```

    Если параметры адресов хранятся в списке сетевых интерфейсов, найдите записи с `one_to_one_nat_spec`.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.k8s.CreateNodeGroup", meta.event_status=="DONE", meta.details.node_template.network_interface_specs=*'"one_to_one_nat_spec"'}
    ```

    Разверните запись и проверьте, что `one_to_one_nat_spec` задан в `primary_v4_address_spec`.

{% endlist %}

#### Создание или изменение группы узлов без автоматического обновления {#create-k8s-without-autoupgrade-for-node-group}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Отберите события, в которых автоматическое обновление группы узлов выключено или поле `auto_upgrade` отсутствует.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.k8s.CreateNodeGroup|{{ at-event-prefix }}.audit.k8s.UpdateNodeGroup", meta.event_status=="DONE", meta.details.node_group_id="*", meta.details.maintenance_policy.auto_upgrade="false|-"}
    ```

    Если поле отсутствует, проверьте политику обновлений группы узлов.

{% endlist %}

### {{ container-registry-full-name }} {#container-registry}

#### Обнаружение критических уязвимостей при сканировании образа {#detect-critical-vulnerabilities}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.containerregistry.ScanImage", meta.details.vulnerability_stats.critical>0}
    ```

{% endlist %}

## Платформа данных {#data-platform}

### {{ objstorage-full-name }} {#object-storage}

#### Изменение политики доступа к бакету {#update-bucket-policy}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.storage.BucketPolicyUpdate"}
    ```

{% endlist %}

#### Открытие публичного доступа при создании или изменении бакета {#public-access-bucket}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Чтобы найти создание бакета с публичным доступом, отберите события создания и проверьте в `meta.details.acl.grants` [разрешения, выданные публичным группам](../../../storage/concepts/acl.md#public-groups).

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.storage.BucketCreate", meta.event_status=="DONE"}
    ```

    Чтобы найти изменения настроек публичного доступа, выполните отдельный запрос для каждого вида доступа.

    Чтение объектов.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.storage.BucketUpdate", meta.event_status=="DONE", meta.details.objects_access=="true"}
    ```

    Чтение списка объектов.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.storage.BucketUpdate", meta.event_status=="DONE", meta.details.list_access=="true"}
    ```

    Чтение настроек бакета.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.storage.BucketUpdate", meta.event_status=="DONE", meta.details.settings_read_access=="true"}
    ```

{% endlist %}

### {{ mpg-full-name }} и {{ mmy-full-name }} {#mdb}

#### Создание или изменение пользователя базы данных {#create-user}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.mdb.postgresql.CreateUser|{{ at-event-prefix }}.audit.mdb.postgresql.UpdateUser|{{ at-event-prefix }}.audit.mdb.mysql.CreateUser|{{ at-event-prefix }}.audit.mdb.mysql.UpdateUser"}
    ```

{% endlist %}

## Безопасность {#security}

### {{ kms-full-name }} {#kms}

#### Изменение ролей для KMS-ключей {#update-key-access-bindings}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.kms.UpdateSymmetricKeyAccessBindings|{{ at-event-prefix }}.audit.kms.SetSymmetricKeyAccessBindings|{{ at-event-prefix }}.audit.kms.asymmetricencryption.UpdateAsymmetricEncryptionKeyAccessBindings|{{ at-event-prefix }}.audit.kms.asymmetricencryption.SetAsymmetricEncryptionKeyAccessBindings"}
    ```

{% endlist %}

### {{ iam-full-name }} {#iam}

#### Действия конкретного пользователя за период времени {#any-actions-user}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Укажите даты начала и окончания периода в интерфейсе {{ monium-name }}. Отберите события по имени пользователя.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.authentication.subject_name=="<имя_пользователя>"}
    ```

{% endlist %}

#### Создание любых ключей для сервисных аккаунтов {#create-sa-keys}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.iam.CreateAccessKey|{{ at-event-prefix }}.audit.iam.CreateKey|{{ at-event-prefix }}.audit.iam.CreateApiKey"}
    ```

{% endlist %}

#### Назначение примитивных привилегированных ролей на ресурсы {#assigning-primitive-privileged-roles}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Укажите идентификатор роли, например `admin`. Найдите эту роль в списке изменений прав доступа.

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_status=="DONE", meta.details.access_binding_deltas=~'.*"role_id"[[:space:]]*:[[:space:]]*"<идентификатор_роли>".*'}
    ```

    Разверните запись и проверьте, что для элемента с этой ролью указано действие `ADD`.

{% endlist %}

### {{ lockbox-full-name }} {#lockbox}

#### Изменение ролей для секретов {#update-secret-access-bindings}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.lockbox.UpdateSecretAccessBindings"}
    ```

{% endlist %}

#### Чтение секрета {#read-secret}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Запрос применим, если трейл собирает [события уровня сервисов {{ lockbox-name }}](../../../lockbox/at-ref.md#data-plane-events).

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type="{{ at-event-prefix }}.audit.lockbox.GetPayload|{{ at-event-prefix }}.audit.lockbox.GetPayloadEx"}
    ```

{% endlist %}

## Поиск ошибок {#errors}

### Поиск ошибок доступа {#permission-denied}

{% list tabs group=tools %}

- {{ monium-name }} {#monium}

    Отберите операции со статусом `ERROR` и кодом ошибки `7` (`PERMISSION_DENIED`).

    ```text
    {project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_status=="ERROR", meta.error.code=="7"}
    ```

{% endlist %}

#### Полезные ссылки {#see-also}

* [Язык запросов {{ monium-name }}](../../../monium/logs/query.md)
* [Формат аудитного лога](../../../audit-trails/concepts/format.md)
