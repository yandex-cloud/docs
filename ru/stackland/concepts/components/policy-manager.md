# Policy Manager

Policy Manager объединяет инструменты, которые проверяют ресурсы Kubernetes на соответствие политикам и генерируют отчеты в формате [OpenReports](https://openreports.io/docs/api/). За уведомлениями Policy Manager можно следить в консоли управления в разделе **Система > События**. Текущая реализация проверки политик основана на [Kyverno](https://kyverno.io/).

В Policy Manager можно выбрать один из двух пресетов политик:

* baseline — пресет, основанный на базовом ([baseline](https://kubernetes.io/docs/concepts/security/pod-security-standards/)) стандарте безопасности Kubernetes для подов.
* restricted — пресет, основанный на защищенном ([restricted](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted)) стандарте безопасности Kubernetes для подов.

Выбрать пресет политик кластера по умолчанию можно с помощью кастомного ресурса `PolicyManagerConfig`. Активировать дополнительный пресет можно с помощью ресурса `ClusterPolicySet`.

## Как выбрать пресет {#how-to-choose}

Пресет baseline применяется по умолчанию. Он подойдет для приложений, сбой или недоступность которых не приводит к серьезным последствиям. Этот пресет защищает от известных способов превышения привилегий в контейнерных средах. Он прост в применении и подойдет для случаев, когда не нужен широкий набор политик для настройки. Посмотреть доступные политики можно в [документации Kubernetes](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline).

Пресет restricted обеспечивает соблюдение текущих рекомендаций по защите подов. Он ориентирован на приложения, критически важные с точки зрения безопасности, а также на пользователей с низким уровнем доверия. Посмотреть доступные политики можно в [документации Kubernetes](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted).

Чтобы добавить новый пресет в кластер, обратитесь к инструкции [Активировать пресет с политиками](../../operations/policy-manager/apply-preset.md). Чтобы изменить пресет по умолчанию, нужно изменить настройки `PolicyManagerConfig`.

## Конфигурация {#configuration}

Пример:

{% include notitle [YAML-файл](../../_includes/yamls/components/policymanagerconfig.md) %}

Где:

* `enabled` — включает использование компонента. Если выбрать `enabled: false`, то все компоненты Policy Manager (Controller, Kyverno, Policy Reporter, ClusterPolicySet) будут удалены.
* `settings.defaultPolicySet.engines` — задает список пресетов политик и инструментов для их проверки.
