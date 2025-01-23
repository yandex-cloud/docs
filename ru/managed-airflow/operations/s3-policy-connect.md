---
title: Подключение {{ maf-full-name }} к бакету {{ objstorage-full-name }} с политикой доступа
description: В сервисе {{ maf-full-name }} вы можете работать с бакетом {{ objstorage-full-name }}, для которого настроены политики доступа.
---

# Подключение к бакету {{ objstorage-full-name }} с политикой доступа

В сервисе {{ maf-full-name }} вы можете работать с бакетом {{ objstorage-full-name }}, для которого настроены [политики доступа](../../storage/security/policy.md). Доступ к бакету осуществляется из отдельной DNS-зоны через внутренний балансировщик, который распределяет трафик по ВМ с NAT. Схема такого подключения приведена ниже. Вместо ВМ `test-s3-vm` будет использоваться кластер {{ AF }}.

![Storage VPC Access](../../_assets/managed-airflow/storage-vpc-access-maf.svg)

## Перед началом работы {#before-you-begin}

1. Создайте сетевую инфраструктуру для доступа к бакету {{ objstorage-name }}, которая изображена на рисунке выше. Создание такой инфраструктуры описано в [практическом руководстве](../../storage/tutorials/storage-vpc-access.md).
1. [Протестируйте созданную инфраструктуру](../../vpc/tutorials/storage-vpc-access.md#check). 
1. Чтобы подключиться к созданному бакету через {{ AF }}, измените политику доступа к бакету. Для этого в [параметре](https://github.com/yandex-cloud-examples/yc-s3-private-endpoint/blob/bb65c064061c4b8ccdef96bb7b4b180acab55f72/bucket.tf#L23) `Action` укажите разрешенные для {{ AF }} действия: `"s3:GetObject, s3:ListBucket"`. После этого примените изменения командой `terraform apply`.

## Подготовьте кластер {{ AF }} {#prepare-airflow}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `my-account` с ролями `vpc.user` и `managed-airflow.integrationProvider`.
1. [Выдайте разрешение](../../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту `my-account` на созданный ранее бакет.
1. [Создайте кластер](cluster-create.md) {{ AF }} и укажите в нем сервисный аккаунт `my-account`.

## Проверьте подключение {#check-connection}

Чтобы проверить подключение к бакету {{ objstorage-name }}, [загрузите DAG-файл](upload-dags.md) в бакет. DAG должен отобразиться в веб-интерфейсе {{ AF }}.
