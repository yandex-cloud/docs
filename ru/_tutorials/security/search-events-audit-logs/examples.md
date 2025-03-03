# Примеры запросов для поиска событий в аудитных логах

В этом разделе собраны наиболее частые запросы для поиска событий в аудитных логах для различных ресурсов {{ yandex-cloud }}. Чтобы получить нужные события, выполните запрос из приведенных примеров.

**Инфраструктура и сеть**   
* [{{ compute-full-name }}](#compute)
    * [Любые действия с виртуальной машиной](#any-actions-vm)
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
    * [Создание кластера с публичным IP-адресом мастера](#create-k8s-with-public-ip-for-master)
    * [Создание кластера без группы безопасности для мастера](#create-k8s-without-security-group-for-master)
    * [Создание кластера без автоматического обновления мастеров](#create-k8s-without-autoupgrade-for-master)
    * [Создание кластера без шифрования etcd](#create-k8s-without-etcd-encryption)
    * [Создание кластера без сетевых политик](#create-k8s-without-network-policy)
    * [Создание группы узлов c публичными IP-адресами](#create-k8s-with-public-ip-for-node-group)
    * [Создание кластера без автоматического обновления группы узлов](#create-k8s-without-autoupgrade-for-node-group)
* [{{ container-registry-full-name }}](#container-registry)
    * [Обнаружение критических уязвимостей при сканировании образа](#detect-critical-vulnerabilities)

**Платформа данных**
* [{{ objstorage-full-name }}](#object-storage)
    * [Изменение политики доступа к бакету](#update-bucket-policy)
    * [Открытие публичного доступа при создании или изменении бакета](#public-access-bucket)
* [Управляемые базы данных (MDB)](#mdb)
    * [Создание или изменение пользователя для MDB](#create-user)

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

## Инфраструктура и сеть {#infrastructure-and-network}

### {{ compute-full-name }} {#compute}

#### Любые действия с виртуальной машиной {#any-actions-vm}

{% list tabs group=at_logs_tools %}

- {{ yq-full-name }}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.details.instance_id") = '<идентификатор_виртуальной_машины>' and (
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.CreateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.DeleteInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.StartInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.StopInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.RestartInstance')
    ```

    Идентификатор можно запросить со списком виртуальных машин в каталоге.

- {{ cloud-logging-full-name }}

    Используйте фильтр:

    ```sql
    json_payload.details.instance_id="<идентификатор_виртуальной_машины>" and (
    json_payload.event_type="yandex.cloud.audit.compute.CreateInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.DeleteInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.StartInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.StopInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.RestartInstance")
    ```

    Идентификатор можно запросить со списком виртуальных машин в каталоге.


{% endlist %}

#### Добавление дополнительного интерфейса к виртуальной машине {#attach-additional-interface-vm}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.AttachInstanceNetworkInterface'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.compute.AttachInstanceNetworkInterface"
    ```

{% endlist %}

#### Добавление доступа к серийной консоли виртуальной машины {#add-access-serial-console-vm}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.CreateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance') and
      JSON_VALUE(data,"$.details.metadata_serial_port_enable") = '1'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.CreateInstance" and
    json_payload.details.metadata_serial_port_enable="1"
    ```

{% endlist %}

#### Создание или изменение виртуальной машины с включенным получением токена через AWS IMDSv1 {#create-vm-aws-imdsv1}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.CreateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance') and
      JSON_VALUE(data,"$.details.metadata_options.aws_v1_http_token") = 'ENABLED'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    (json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.CreateInstance") and
    json_payload.details.metadata_options.aws_v1_http_token="ENABLED"
    ```

{% endlist %}

### {{ vpc-full-name }} {#vpc}

#### Любые действия с определенного IP-адреса {#any-actions-ip}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.request_metadata.remote_address") = '<IP-адрес>' 
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.request_metadata.remote_address = "<IP-адрес>"
    ```

{% endlist %}

#### Добавление публичного IP-адреса к виртуальной машине {#address-attached}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.network.AddressAttached'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.network.AddressAttached"
    ```

{% endlist %}

#### Создание или изменение группы безопасности {#create-security-group}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.CreateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.network.CreateSecurityGroup" or
    json_payload.event_type="yandex.cloud.audit.network.UpdateSecurityGroup"
    ```

{% endlist %}

## Мониторинг и управление ресурсами {#monitoring-and-resource-management}

### {{ org-full-name }} {#organization}

#### Удаление каталога {#delete-folder}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.resourcemanager.DeleteFolder' and
      JSON_VALUE(data,"$.details.folder_name") = '<имя_каталога>'
    ```

    Имя каталога можно запросить со списком каталогов в облаке.

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_name="<имя_каталога>"
    ```

    Имя каталога можно запросить со списком каталогов в облаке.


{% endlist %}

#### Создание федерации {#create-federation}

{% list tabs group=tools %}

- {{ yq-full-name }}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.organizationmanager.saml.CreateFederation'
    ```

- {{ cloud-logging-full-name }}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.organizationmanager.saml.CreateFederation"
    ```

{% endlist %}

#### Изменение федерации {#update-federation}

{% list tabs group=tools %}

- {{ yq-full-name }}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.organizationmanager.saml.UpdateFederation'
    ```

- {{ cloud-logging-full-name }}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.organizationmanager.saml.UpdateFederation"
    ```

{% endlist %}

#### Добавление сертификата в федерацию {#create-certificate}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.organizationmanager.saml.CreateCertificate'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.organizationmanager.saml.CreateCertificate"
    ```

{% endlist %}

#### Обнаружение облачного секрета в открытом доступе {#detect-leaked-credential}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.organizationmanager.DetectLeakedCredential'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.organizationmanager.DetectLeakedCredential"
    ```

{% endlist %}

## Контейнеры {#containers}

### {{ managed-k8s-full-name }} {#k8s}

#### Создание кластера с публичным IP-адресом мастера {#create-k8s-with-public-ip-for-master}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' and
      JSON_EXISTS(data,"$.request_parameters.master_spec.zonal_master_spec.external_v4_address_spec.address")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" and
    json_payload.request_parameters.master_spec.zonal_master_spec.external_v4_address_spec.address exists
    ```

{% endlist %}

#### Создание кластера без группы безопасности для мастера {#create-k8s-without-security-group-for-master}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.UpdateCluster') and not
      JSON_EXISTS(data,"$.request_parameters.master_spec.security_group_ids")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    (json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" or 
    json_payload.event_type = "yandex.cloud.audit.k8s.UpdateCluster") and not
    json_payload.request_parameters.master_spec.security_group_ids exists
    ```

{% endlist %}

#### Создание кластера без автоматического обновления мастеров {#create-k8s-without-autoupgrade-for-master}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.UpdateCluster') and not
      JSON_EXISTS(data,"$.request_parameters.master_spec.maintenance_policy.auto_upgrade")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    (json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" or 
    json_payload.event_type = "yandex.cloud.audit.k8s.UpdateCluster") and not
    json_payload.request_parameters.master_spec.maintenance_policy.auto_upgrade exists
    ```

{% endlist %}

#### Создание кластера без шифрования etcd {#create-k8s-without-etcd-encryption}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' and not
      JSON_EXISTS(data,"$.request_parameters.kms_provider.key_id")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" and not
    json_payload.request_parameters.kms_provider.key_id exists
    ```

{% endlist %}

#### Создание кластера без сетевых политик {#create-k8s-without-network-policy}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' and not
      JSON_EXISTS(data,"$.request_parameters.network_policy.provider")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" and not
    json_payload.request_parameters.network_policy.provider exists
    ```

{% endlist %}

#### Создание группы узлов c публичными IP-адресами {#create-k8s-with-public-ip-for-node-group}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateNodeGroup' or 
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.UpdateNodeGroup') and 
      JSON_EXISTS(data,"$.request_parameters.node_template.v4_address_spec.one_to_one_nat_spec")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    (json_payload.event_type = "yandex.cloud.audit.k8s.CreateNodeGroup" or
    json_payload.event_type = "yandex.cloud.audit.k8s.CreateNodeGroup") and
    json_payload.request_parameters.node_template.v4_address_spec.one_to_one_nat_spec exists 
    ```

{% endlist %}

#### Создание кластера без автоматического обновления группы узлов {#create-k8s-without-autoupgrade-for-node-group}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateNodeGroup' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.UpdateNodeGroup') and not
      JSON_EXISTS(data,"$.request_parameters.maintenance_policy.auto_upgrade")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    (json_payload.event_type = "yandex.cloud.audit.k8s.CreateNodeGroup" or 
    json_payload.event_type = "yandex.cloud.audit.k8s.UpdateNodeGroup") and not
    json_payload.request_parameters.maintenance_policy.auto_upgrade exists
    ```

{% endlist %}

### {{ container-registry-full-name }} {#container-registry}

#### Обнаружение критических уязвимостей при сканировании образа {#detect-critical-vulnerabilities}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.containerregistry.ScanImage' and
      JSON_VALUE(data,"$.details.vulnerability_stats.critical") > 0
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.containerregistry.ScanImage" and
    json_payload.details.vulnerability_stats.critical > 0
    ```

{% endlist %}

## Платформа данных {#data-platform}

### {{ objstorage-full-name }} {#object-storage}

#### Изменение политики доступа к бакету {#update-bucket-policy}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.storage.BucketPolicyUpdate'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.storage.BucketPolicyUpdate"
    ```

{% endlist %}

#### Открытие публичного доступа при создании или изменении бакета {#public-access-bucket}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.storage.BucketUpdate' and
      (JSON_VALUE(data,"$.details.objects_access") = 'true' or
      JSON_VALUE(data,"$.details.settings_read_access") = 'true' or
      JSON_VALUE(data,"$.details.list_access") = 'true')
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.storage.BucketUpdate" and
    (json_payload.details.objects_access: "true" or
    json_payload.details.settings_read_access: "true" or
    json_payload.details.list_access: "true")
    ```

{% endlist %}

### Управляемые базы данных (MDB) {#mdb}

#### Создание или изменение пользователя для MDB {#create-user}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.mdb.postgresql.CreateUser' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.mdb.postgresql.UpdateUser' or 
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.mdb.mysql.UpdateUser' or 
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.mdb.mysql.CreateUser'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.mdb.postgresql.CreateUser" or 
    json_payload.event_type = "yandex.cloud.audit.mdb.postgresql.UpdateUser" or 
    json_payload.event_type = "yandex.cloud.audit.mdb.mysql.UpdateUser" or
    json_payload.event_type = "yandex.cloud.audit.mdb.mysql.CreateUser"
    ```

{% endlist %}

## Безопасность {#security}

### {{ kms-full-name }} {#kms}

#### Изменение ролей для KMS-ключей {#update-key-access-bindings}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.kms.UpdateSymmetricKeyAccessBindings' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.kms.SetSymmetricKeyAccessBindings' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.kms.UpdateAsymmetricEncryptionKeyAccessBindings' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.kms.SetAsymmetricEncryptionKeyAccessBindings'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.kms.UpdateSymmetricKeyAccessBindings" or
    json_payload.event_type="yandex.cloud.audit.kms.SetSymmetricKeyAccessBindings" or
    json_payload.event_type="yandex.cloud.audit.kms.UpdateAsymmetricEncryptionKeyAccessBindings" or
    json_payload.event_type="yandex.cloud.audit.kms.SetAsymmetricEncryptionKeyAccessBindings"
    ```

{% endlist %}

### {{ iam-full-name }} {#iam}

#### Действия конкретного пользователя за период времени {#any-actions-user}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from
      bindings.`binding`
    where
      JSON_VALUE(data,"$.authentication.subject_name") = '<имя_пользователя>' and
      cast(JSON_VALUE(data, "$.event_time") as Timestamp) > Date("<дата_начала_периода>")
    limit 10
    ```

    Дата задается в формате `ГГГГ-ММ-ДД`.

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.authentication.subject_name="<имя_пользователя>" and
    json_payload.event_time>"<дата_начала_периода>" and
    json_payload.event_time<"<дата_окончания_периода>"
    ```

    Дата задается в формате `ГГГГ-ММ-ДД`.

{% endlist %}

#### Создание любых ключей для сервисных аккаунтов {#create-sa-keys}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.iam.CreateAccessKey' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.iam.CreateKey' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.iam.CreateApiKey'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.iam.CreateAccessKey" or
    json_payload.event_type="yandex.cloud.audit.iam.CreateKey" or
    json_payload.event_type="yandex.cloud.audit.iam.CreateApiKey"
    ```

{% endlist %}

#### Назначение примитивных привилегированных ролей на ресурсы {#assigning-primitive-privileged-roles}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from
      bindings.`binding`
    where
      JSON_VALUE(data,"$.details.access_binding_deltas.access_binding.role_id") = '<примитивная_роль>'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.details.access_binding_deltas.access_binding.role_id="<примитивная_роль>"
    ```

{% endlist %}

### {{ lockbox-full-name }} {#lockbox}

#### Изменение ролей для секретов {#update-secret-access-bindings}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.lockbox.UpdateSecretAccessBindings' 
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.lockbox.UpdateSecretAccessBindings"
    ```

{% endlist %}

#### Чтение секрета {#read-secret}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Выполните запрос:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.lockbox.GetPayload'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Используйте фильтр:

    ```sql
    json_payload.event_type="yandex.cloud.audit.lockbox.GetPayload"
    ```

{% endlist %}
