---
title: "Изменение кластера {{ AF }}"
description: "После создания кластера вы можете изменить его основные и дополнительные настройки."
keywords:
  - изменение кластера {{ AF }}
  - кластер {{ AF }}
  - {{ AF }}
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

    1. В блоке **{{ ui-key.yacloud.airflow.section_triggerer }}** включите или отключите службу Triggerer. Если служба включена, укажите количество экземпляров и ресурсов.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** вставьте значения [статического ключа доступа](../../iam/concepts/authorization/access-key.md) для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

    1. В блоке **{{ ui-key.yacloud.airflow.section_dependencies }}** удалите или добавьте названия pip- и deb-пакетов.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** установите или снимите защиту от удаления.

    1. В блоке **{{ ui-key.yacloud.airflow.section_airflow-configuration }}** измените, удалите или добавьте [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), например: ключ — `api.maximum_page_limit`, значение — `150`. Заполните поля вручную или загрузите конфигурацию из файла (см. [пример конфигурационного файла](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
