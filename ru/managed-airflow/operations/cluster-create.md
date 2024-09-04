---
title: "Создание кластера {{ AF }}"
description: "Каждый кластер {{ maf-name }} состоит из набора компонентов {{ AF }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности."
keywords:
  - создание кластера {{ AF }}
  - кластер {{ AF }}
  - {{ AF }}
  - Airflow
---

# Создание кластера {{ AF }}

Каждый [кластер](../../glossary/cluster.md) {{ maf-name }} состоит из набора компонентов {{ AF }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности.

## Перед созданием кластера {#before-creating}

1. В каталоге, в котором планируется создать кластер, [создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `managed-airflow.integrationProvider`.
1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md), в котором будут храниться [DAG-файлы](../concepts/index.md#about-the-service).
1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у вашего аккаунта есть роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.maf.editor }} или выше](../security/index.md#roles-list) для создания кластера.

## Создайте кластер {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  @[youtube](https://www.youtube.com/watch?v=vWCmvbrhDsI)


  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Введите имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):
            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

  1. В блоке **{{ ui-key.yacloud.airflow.section_accesses }}**:

        * Задайте пароль пользователя-администратора. Пароль должен иметь длину не менее 8 символов и содержать как минимум:
            * одну заглавную букву;
            * одну строчную букву;
            * одну цифру;
            * один специальный символ.

           {% note info %}

           Сохраните пароль локально или запомните его. Сервис не показывает пароли после создания.

           {% endnote %}

        * Выберите [созданный ранее](#before-creating) сервисный аккаунт с ролью `managed-airflow.integrationProvider`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите:

      * [зоны доступности](../../overview/concepts/geo-scope) для размещения кластера;
      * облачную сеть;
      * подсеть в каждой из выбранных зон доступности;
      * [группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера.

        {% include [sg-ui-access](../../_includes/mdb/maf/note-sg-ui-access.md) %}

  1. Задайте количество экземпляров и ресурсы для [компонентов](../concepts/index.md#components) {{ maf-name }}:

      * веб-сервера;
      * планировщика;
      * воркеров;

        {% note info %}

        Если очередь задач пуста, количество воркеров будет равно минимальному значению. При появлении задач количество воркеров будет увеличиваться вплоть до максимального значения.

        {% endnote %}

      * (опционально) службы Triggerer.

  1. (Опционально) В блоке **{{ ui-key.yacloud.airflow.section_dependencies }}** укажите названия pip- и deb-пакетов, чтобы установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов.

      Чтобы указать более одного пакета, нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

      При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

      ```text
      pandas==2.0.2
      scikit-learn>=1.0.0
      clickhouse-driver~=0.2.0
      ```

      Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

      {% note warning %}

      Для установки pip- и deb-пакетов из публичных репозиториев необходимо в блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** указать сеть с настроенным [NAT в интернет](../../vpc/operations/create-nat-gateway.md).

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.airflow.section_storage }}** задайте имя ранее созданного бакета, в котором будут храниться DAG-файлы.

  1. (Опционально) В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** включите защиту от удаления кластера.

  1. (Опционально) В блоке **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**:
  
      * Задайте [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), например: ключ — `api.maximum_page_limit`, значение — `150`.

        Заполните поля вручную или загрузите конфигурацию из файла (см. [пример конфигурационного файла](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

      * Включите опцию **{{ ui-key.yacloud.airflow.field_lockbox }}**, чтобы использовать секреты в сервисе [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) {{ AF }}.

        {% include [sa-roles-for-lockbox](../../_includes/managed-airflow/sa-roles-for-lockbox.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
