# Интеграция с Object Storage

Интеграция с Object Storage позволяет уменьшить объем данных на дисках [инстанса](../concepts/index.md#instance) и предотвратить их переполнение. Вы можете выбрать типы данных, которые будут храниться в Object Storage:

* `Артефакты` — архивы файлов и каталогов заданий.
* `Внешние diff-файлы` — файлы, содержащие различия между версиями в мерж-реквестах.
* `Файлы вложений` — пользовательские файлы.
* `Git LFS` — [хранилище больших файлов](https://git-lfs.com/).
* `Пакеты` — реестр пакетов.
* `Прокси зависимостей` — кеш зависимостей.
* `Состояния Terraform` — файлы состояния Terraform.
* `GitLab Pages` — веб-сайты.
* `Защищенные файлы CI` — файлы с ограниченным доступом.
* `Container Registry` — образы контейнеров.

[Подробнее об интеграции с Object Storage](../concepts/s3-integration.md).

## Посмотреть список хранимых в Object Storage данных {#objstorage-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **Данные в Object Storage**.

{% endlist %}

## Включить хранение данных в Object Storage {#enable-objstorage}

{% note alert %}

Если отключить хранение данных в Object Storage, существующие данные станут недоступны в инстансе. Обратная миграция в локальное хранилище GitLab не предусмотрена. Новые данные будут сохраняться в локальном хранилище GitLab.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **Данные в Object Storage**.
  1. Нажмите кнопку **Настроить хранение данных в Object Storage**.
  1. Выберите типы данных для хранения в Object Storage.
    
      Для каждого выбранного типа данных можно включить проксирование файлов. При этом файлы будут загружаться через сервер GitLab.

  1. Нажмите кнопку **Сохранить**.

      {% note info %}
      
      Миграция файлов из больших репозиториев в Object Storage может занять более суток.
      
      {% endnote %}

{% endlist %}