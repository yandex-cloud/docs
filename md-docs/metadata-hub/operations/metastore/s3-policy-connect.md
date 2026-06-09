# Подключение к бакету Yandex Object Storage с политикой доступа

В сервисе Apache Hive™ Metastore вы можете работать с бакетом Yandex Object Storage, для которого настроены [политики доступа](../../../storage/security/policy.md). Доступ к бакету осуществляется из отдельной DNS-зоны через внутренний балансировщик, который распределяет трафик по ВМ с NAT. Схема такого подключения приведена ниже. Вместо ВМ `test-s3-vm` будет использоваться кластер Apache Hive™ Metastore.

![Storage VPC Access](../../../_assets/metadata-hub/storage-vpc-access-metastore.svg)

## Перед началом работы {#before-you-begin}

1. Создайте сетевую инфраструктуру для доступа к бакету Object Storage, которая изображена на рисунке выше. Создание такой инфраструктуры описано в [практическом руководстве](../../../storage/tutorials/storage-vpc-access.md).
1. [Протестируйте созданную инфраструктуру](../../../vpc/tutorials/storage-vpc-access.md#check). 

## Подготовьте кластер Apache Hive™ Metastore {#prepare-metastore}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `my-account` с ролями `storage.uploader` и `managed-metastore.integrationProvider`.
1. [Выдайте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` сервисному аккаунту `my-account` на созданный ранее бакет.
1. [Настройте сеть и создайте кластер](cluster-create.md) Apache Hive™ Metastore. При создании укажите сервисный аккаунт `my-account`.

## Проверьте подключение {#check-connection}

Чтобы проверить подключение к бакету Object Storage, [экспортируйте в него данные кластера Apache Hive™ Metastore](export-and-import.md#export). 

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._