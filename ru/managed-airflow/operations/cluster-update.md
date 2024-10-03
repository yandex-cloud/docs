---
title: Изменение кластера {{ AF }}
description: После создания кластера вы можете изменить его основные и дополнительные настройки.
keywords:
  - изменение кластера {{ AF }}
  - кластер {{ AF }}
  - '{{ AF }}'
  - Airflow
---

# Изменение кластера {{ AF }}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.

    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** измените имя и описание кластера, удалите или добавьте новые метки.

    1. В блоке **{{ ui-key.yacloud.airflow.section_accesses }}** выберите сервисный аккаунт или [создайте новый](../../iam/operations/sa/create.md#create-sa) с ролью  `managed-airflow.integrationProvider`. Это даст кластеру нужные права для работы с пользовательскими ресурсами. Подробнее см. в разделе [Имперсонация](../concepts/impersonation.md).
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите [группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера или создайте ее.

       {% include [sg-ui-access](../../_includes/mdb/maf/note-sg-ui-access.md) %}

    1. В блоках для настройки [компонентов](../concepts/index.md#components) {{ maf-name }} — **{{ ui-key.yacloud.airflow.section_webserver }}**, **{{ ui-key.yacloud.airflow.section_scheduler }}**, **{{ ui-key.yacloud.airflow.section_workers }}** — укажите количество экземпляров и ресурсов.

    1. В блоке **{{ ui-key.yacloud.airflow.section_triggerer }}** включите или выключите службу Triggerer. Если служба включена, укажите количество экземпляров и ресурсов.

    1. В блоке **{{ ui-key.yacloud.airflow.section_dependencies }}** удалите или добавьте названия pip- и deb-пакетов.

    1. В блоке **{{ ui-key.yacloud.airflow.section_storage }}** выберите существующий бакет для хранения DAG-файлов или создайте новый. Сервисному аккаунту кластера должно быть [предоставлено разрешение](../../storage/operations/buckets/edit-acl.md) `READ` для этого бакета.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** установите или снимите защиту от удаления.

    1. В блоке **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**:

        * Добавьте, измените или удалите [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), например: ключ — `api.maximum_page_limit`, значение — `150`.

            Заполните поля вручную или загрузите конфигурацию из файла (см. [пример конфигурационного файла](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

        * Включите или выключите опцию **{{ ui-key.yacloud.airflow.field_lockbox }}**, которая позволяет использовать секреты в сервисе [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) {{ AF }}.

            {% include [sa-roles-for-lockbox](../../_includes/managed-airflow/sa-roles-for-lockbox.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
