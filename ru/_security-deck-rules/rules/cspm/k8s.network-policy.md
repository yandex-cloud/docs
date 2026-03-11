### Настроен сбор аудитных логов для расследований инцидентов {#network-policy}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | k8s.network-policy ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Данное правило требует ручной проверки настройки сбора аудитных логов.

{% endnote %}

События, доступные пользователю в рамках сервиса Managed Service for Kubernetes, можно разделить на следующие уровни:

* события Kubernetes API (Kubernetes Audit logging);
* события узлов Kubernetes;
* события подов Kubernetes;
* метрики Kubernetes;
* Flow logs Kubernetes.

Подробнее о настройке сбора событий аудита на разных уровнях см. в разделе [Сбор, мониторинг и анализ аудитных логов Managed Service for Kubernetes](https://yandex.cloud/ru/docs/security/domains/kubernetes#collection-monitoring-analysis-audit-logs).

#### Инструкции и решения по выполнению

Managed Service for Kubernetes предоставляет возможность проводить аудит текущей ролевой модели в сервисе. Для этого в консоли управления откройте страницу кластера Kubernetes и перейдите на вкладку **Управление доступом**.

Также можно использовать:

* [KubiScan](https://github.com/cyberark/KubiScan).
* [Krane](https://github.com/appvia/krane).
* [Аудитные логи](https://yandex.cloud/ru/docs/managed-kubernetes/at-ref) Yandex Audit Trails.