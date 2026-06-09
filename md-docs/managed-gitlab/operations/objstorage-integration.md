# Интеграция с {{ objstorage-name }}

Интеграция с {{ objstorage-name }} позволяет уменьшить объем данных на дисках [инстанса](../concepts/index.md#instance) и предотвратить их переполнение. Вы можете выбрать типы данных, которые будут храниться в {{ objstorage-name }}:

* `Артефакты` — архивы файлов и каталогов заданий.
* `Внешние diff-файлы` — файлы, содержащие различия между версиями в мерж-реквестах.
* `Файлы вложений` — пользовательские файлы.
* `Git LFS` — [хранилище больших файлов](https://git-lfs.com/).
* `Пакеты` — реестр пакетов.
* `Прокси зависимостей` — кеш зависимостей.
* `Состояния Terraform` — файлы состояния {{ TF }}.
* `GitLab Pages` — веб-сайты.
* `Защищенные файлы CI` — файлы с ограниченным доступом.
* `Container Registry` — образы контейнеров.

[Подробнее об интеграции с {{ objstorage-name }}](../concepts/s3-integration.md).

## Посмотреть список хранимых в {{ objstorage-name }} данных {#objstorage-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.gitlab.title_object-storage }}**.

{% endlist %}

## Включить хранение данных в {{ objstorage-name }} {#enable-objstorage}

{% note alert %}

Если отключить хранение данных в {{ objstorage-name }}, существующие данные станут недоступны в инстансе. Обратная миграция в локальное хранилище {{ GL }} не предусмотрена. Новые данные будут сохраняться в локальном хранилище {{ GL }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.gitlab.title_object-storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_configure-data-types }}**.
  1. Выберите типы данных для хранения в {{ objstorage-name }}.
    
      Для каждого выбранного типа данных можно включить проксирование файлов. При этом файлы будут загружаться через сервер {{ GL }}.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

      {% note info %}
      
      Миграция файлов из больших репозиториев в {{ objstorage-name }} может занять более суток.
      
      {% endnote %}

{% endlist %}