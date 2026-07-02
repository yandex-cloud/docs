[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for GitLab](index.md) > История изменений

# История изменений в Yandex Managed Service for GitLab

## IV квартал 2025 {#q4-2025}

Добавлены новые параметры для воркеров GitLab, которые создаются [управляемыми Yandex Cloud раннерами](tutorials/install-gitlab-runner.md#create-runner):
* [группы безопасности](../vpc/concepts/security-groups.md) для разграничения сетевого доступа воркера;
* [сервисный аккаунт](../iam/concepts/users/service-accounts.md), от имени которого воркер аутентифицируется в Yandex Cloud из пайплайнов CI/CD.

## III квартал 2025 {#q3-2025}

Поддержана возможность [хранения данных GitLab в Yandex Object Storage](concepts/s3-integration.md).

## II квартал 2025 {#q2-2025}

* Добавлена поддержка управления инстансами GitLab с помощью [CLI](cli-ref/index.md), [Terraform](tf-ref.md) и [API](api-ref/authentication.md).
* Реализована возможность выбора [группы безопасности](../vpc/concepts/security-groups.md) при [создании](operations/instance/instance-create.md) и [изменении](operations/instance/instance-update.md) инстанса GitLab. Подробнее на странице [Настройка групп безопасности](operations/configure-security-group.md).
* Поддержана функциональность [получения информации об операциях в сервисе](operations/instance/instance-list.md) с помощью CLI и API.

## I квартал 2025 {#q1-2025}

### Новые возможности {#q1-2025-new-features}

* Добавлена возможность выпуска TLS-сертификатов Let's Encrypt через сервис [Yandex Certificate Manager](../certificate-manager/index.md). Чтобы переключиться на выпуск сертификатов через Certificate Manager, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).
* Поддержана функциональность [GitLab Pages](concepts/index.md#pages) на стадии [Preview](../overview/concepts/launch-stages.md). 

### Исправления и улучшения {#q1-2025-problems-solved}

* Улучшена генерация основного файла конфигурации GitLab, что уменьшает вероятность расхождения конфигураций.
* Улучшен механизм автоматического обновления инстансов GitLab.

## Октябрь 2024 {#oct-2024}

Добавлена возможность мониторинга состояния инстанса GitLab в консоли управления Yandex Cloud. Графики состояния можно посмотреть на вкладке **Мониторинг** или в сервисе [Yandex Monitoring](../monitoring/concepts/index.md). Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md).

## Сентябрь 2024 {#sep-2024}

Добавлена возможность управлять агентами GitLab Runner с помощью консоли управления Yandex Cloud. Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md). Чтобы получить к ней доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

## Июль 2024 {#jul-2024}

1 июля 2024 года функциональность [правил ревью кода](concepts/approval-rules.md) перешла на стадию [General Availability](../overview/concepts/launch-stages.md), и за ее использование теперь взимается плата в соответствии с [правилами тарификации](pricing.md#prices-instance).


## Март 2024 {#mar-2024}

Для инстансов, находящихся в зоне доступности `ru-central1-c`, добавлена возможность [миграции в другую зону](operations/instance/zone-migration.md).


## Январь 2024 {#jan-2024}

* Добавлен провайдер аутентификации [Yandex ID](operations/omniauth.md#yandex-id).
* Добавлена услуга по [миграции инстанса](concepts/migration.md) из GitLab в Managed Service for GitLab. Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md).