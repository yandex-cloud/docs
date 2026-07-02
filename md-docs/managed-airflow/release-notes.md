[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for Apache Airflow™](index.md) > История изменений

# История изменений в Yandex Managed Service for Apache Airflow™

## Октябрь 2025 {#oct-2025}

* Поддержаны [версии](concepts/versions.md) Airflow 3.0 и 3.1.
* Для версий Airflow 3.0 и выше добавлен новый компонент — [DAG-процессор](concepts/index.md#components). Его можно настроить при [создании](operations/cluster-create.md) или [изменении](operations/cluster-update.md) кластера.

## Май 2025 {#may-2025}

В консоли управления добавлен раздел [**Обслуживание**](operations/cluster-maintenance.md).

## Ноябрь 2024 {#nov-2024}

Добавлена возможность выбирать [конфигурацию](concepts/index.md#presets) (vCPU и RAM) для каждого компонента кластера при его [создании](operations/cluster-create.md) или [редактировании](operations/cluster-update.md).

## Сентябрь 2024 {#sep-2024}

* 16 сентября 2024 Managed Service for Apache Airflow™ перешел на стадию [General Availability](../overview/concepts/launch-stages.md), и за его использование начала взиматься плата в соответствии с [правилами тарификации](pricing.md).
* Добавлена возможность совершать операции над кластером Apache Airflow™ с помощью [CLI Yandex Cloud](../cli/cli-ref/managed-airflow/cli-ref/index.md), [Terraform](tf-ref.md) и [API](api-ref/authentication.md).

## Июнь 2024 {#jun-2024}

* Логи заданий Apache Airflow™ теперь сохраняются в Yandex Object Storage. Это решает проблему с недоступностью логов на выключенных воркерах после отработавшего автомасштабирования.
* Добавлена возможность хранить подключения, переменные и конфигурационные данные, которые используются в DAG-файлах, в Yandex Lockbox. Подробнее в инструкции [Хранение подключений в Yandex Lockbox](operations/lockbox-secrets-in-maf-cluster.md).

## Май 2024 {#may-2024}

Добавлена возможность назначить кластеру сервисный аккаунт, от имени которого кластер будет обращаться к другим сервисам Yandex Cloud, например Cloud Logging, Yandex Monitoring и Yandex Lockbox. Также это дает возможность использовать весь функционал Yandex Cloud SDK при написании DAG-скриптов без необходимости дополнительной настройки авторизации.

## Апрель 2024 {#apr-2024}

* Добавлена возможность устанавливать deb-пакеты в качестве зависимостей при [создании](operations/cluster-create.md) или [изменении](operations/cluster-update.md) кластера.
* При возникновении проблем во время установки pip- и deb-зависимостей теперь отображается понятный текст ошибки. Также, если указаны неправильные пакеты, то операция изменения кластера откатывается с возможностью изменить ввод без обращения в службу поддержки.
* Скрипты в DAG-файлах теперь запускаются быстрее.