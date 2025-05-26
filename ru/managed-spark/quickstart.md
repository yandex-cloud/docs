---
title: Начало работы с {{ msp-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ msp-full-name }} и запускать в нем задания.
---

# Как начать работать с {{ msp-full-name }}

{% include notitle [preview](../_includes/note-preview.md) %}

Чтобы начать работу с сервисом:

* [Подготовьте облако к работе](#prepare-cloud).
* [Подготовьте инфраструктуру](#prepare-infrastructure).
* [Создайте кластер](#cluster-create).
* [Подготовьте задание PySpark](#prepare-task).
* [Запустите задание в кластере](#run-task).
* [Проверьте выполнение задания](#check-task).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за использование бакета {{ objstorage-full-name }} (см. [тарифы {{ objstorage-name }}](../storage/pricing.md)).

## Подготовьте облако к работе {#prepare-cloud}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * [managed-spark.admin](security.md#managed-spark-admin) — чтобы создать кластер;
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

## Подготовьте инфраструктуру {#prepare-infrastructure}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md#create-sa) и назначьте ему роли:

   * `managed-spark.integrationProvider` — для взаимодействия {{ msp-name }} с другими сервисами (например для отправки логов и метрик).
   * [storage.editor](../storage/security/index.md#storage-editor) — для доступа к файлам с PySpark-заданиями в бакете {{ objstorage-name }}.

1. [Создайте бакет {{ objstorage-name }}](../storage/operations/buckets/create.md).

1. Предоставьте сервисному аккаунту доступ к бакету {{ objstorage-name }}, в котором будут храниться код и данные для заданий на кластере:

   1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Откройте [созданный ранее](#create-s3-bucket) бакет.
      1. Перейдите в раздел **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
      1. Нажмите на кнопку ![image](../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
      1. В открывшемся окне **{{ ui-key.yacloud.component.acl-dialog.label_title }}**:

         1. Начните вводить имя [созданного ранее](#before-you-begin) сервисного аккаунта и выберите его из выпадающего списка.
         1. Выберите права доступа {{ ui-key.yacloud.storage.permissions-dialog.label_role-write }}.
         1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
         1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

## Создайте кластер {#cluster-create}

{% list tabs group=instructions %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Задайте имя кластера.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите [созданный ранее](#before-you-begin) сервисный аккаунт.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть, подсеть и группу безопасности для кластера.
  1. Задайте вычислительные ресурсы для хостов, на которых будут запускаться драйверы и исполнители.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** настройте логирование:

     1. Включите настройку **{{ ui-key.yacloud.logging.field_logging }}**.
     1. В поле **{{ ui-key.yacloud.logging.label_destination }}** выберите место записи логов — **{{ ui-key.yacloud.common.folder }}**.
     1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** выберите ваш каталог из списка.
     1. Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** — **INFO**.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ msp-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

{% endlist %}

## Подготовьте задание PySpark {#prepare-task}

1. Сохраните на локальный компьютер файл с кодом задания [pi.py](https://github.com/apache/spark/blob/master/examples/src/main/python/pi.py) из репозитория {{ SPRK }}. Этот код вычисляет приблизительное значение числа Пи методом Монте-Карло.

1. Загрузите файл в [созданный ранее](#before-you-begin) бакет {{ objstorage-name }}.

## Запустите задание PySpark {#run-task}

1. В [консоли управления]({{ link-console-main }}) откройте созданный ранее кластер.
1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.spark.jobs.create_action }}**.
1. Выберите **Тип задания** — **{{ ui-key.yacloud.dataproc.jobs.field_pyspark-job-type }}**.
1. В поле **Main python файл** введите путь к файлу `pi.py` в формате `s3a://<имя_бакета_Object_Storage>/<имя_файла>`.
1. Нажмите кнопку **Создать задание**.

## Проверьте выполнение задания {#check_task}

1. Дождитесь, пока запущенное задание перейдет в статус **Running**.
1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.
1. В логах найдите строку с результатом выполнения задания, например:

   ```
   Pi is roughly 3.144720
   ```
