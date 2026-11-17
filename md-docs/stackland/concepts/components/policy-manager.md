[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > Концепции > [Компоненты](overview.md) > Policy Manager

# Policy Manager

Policy Manager проверяет ресурсы Kubernetes на соответствие политикам и
сканирует образы пользовательских приложений на известные уязвимости. Проверки
политик выполняет [Kyverno](https://kyverno.io/), а образы сканирует Trivy
Operator. Результаты доступны в консоли управления и в ресурсах Kubernetes.

{% note warning %}

Найденные уязвимости не блокируют создание, запуск или перезапуск подов. Trivy
работает только в режиме формирования отчетов.

{% endnote %}

## Политики безопасности {#policies}

В Policy Manager доступны два пресета политик:

* baseline — базовый стандарт [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline);
* restricted — защищенный стандарт [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted).

Пресет baseline применяется по умолчанию. Он подойдет для приложений, сбой или
недоступность которых не приводит к серьезным последствиям. Пресет restricted
предназначен для критичных приложений и пользователей с низким уровнем доверия.

Пресет по умолчанию задается в ресурсе `PolicyManagerConfig`. Дополнительный
пресет можно активировать ресурсом `ClusterPolicySet` по инструкции
[Активировать пресет политик](../../operations/policy-manager/apply-preset.md).
Оба пресета работают в audit-режиме и формируют отчеты о нарушениях.

## Сканирование образов {#image-scanning}

Сканирование включено по умолчанию. Для каждого образа актуальной версии
пользовательской нагрузки Trivy Operator создает ресурс `VulnerabilityReport`.
Если в нем есть находки, адаптер создает отдельный стандартный `PolicyReport`,
доступный существующим потребителям отчетов Policy Manager. Когда список
находок становится пустым, адаптер удаляет только связанный `PolicyReport`. Все
уровни серьезности сохраняются в `VulnerabilityReport`.

Для приватного пользовательского образа оператор читает ServiceAccount исходной
нагрузки, находит указанные в нем `imagePullSecrets` и передает эти учетные
данные заданию сканирования. Сам scan job работает от ServiceAccount оператора в
пространстве имен Policy Manager. Если найденных данных недостаточно для
загрузки образа, отчет не будет создан.

Базы для пакетов ОС и Java-библиотек поставляются в отдельных образах.
Основная база устанавливается initContainer сервера Trivy, Java DB — отдельным
initContainer в общий кеш каждого scan job. Образ сканера не содержит архивов
баз. В поставку входят offline-базы, поэтому для их
получения стандартной конфигурации не нужен доступ в интернет. Чтобы обновлять
базы независимо от релизов Stackland, укажите доступные зеркала:
`database.registry` вместе с `database.repository` для основной базы и
`database.javaRegistry` вместе с `database.javaRepository` для Java DB. Оба
зеркала должны разрешать анонимное чтение образов: учетные данные реестра
пользовательской нагрузки для загрузки баз не используются. Основную базу
скачивает один Trivy Server. Внешняя Java DB загружается отдельно в каждый scan
job (около 1 ГБ на одно сканирование), поэтому при ее использовании учитывайте
пропускную способность реестра и `scanJobTimeout`. Встроенная Java DB сетевой
загрузки не требует. Каждый scanner container в scan job запрашивает `3Gi` и
ограничен `6Gi` временного хранилища для Java DB и распакованных слоев образа;
суммарные значения для job умножаются на число контейнеров исходной нагрузки.

Подробнее о просмотре результатов см. в инструкции
[Посмотреть отчеты об уязвимостях](../../operations/policy-manager/view-vulnerability-reports.md).

## Конфигурация {#configuration}

Пример:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: PolicyManagerConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    defaultPolicySet:
      engines:
        kyverno: # имя инструмента
          presets:
            - baseline      # основан на Pod Security Standards Baseline (default)
            # - restricted  # основан на Pod Security Standards Restricted (optional)
    trivy:
      enabled: true # сканирование образов включено по умолчанию
      settings:
        scanner:
          reportTTL: 24h
          scanJobTimeout: 5m
          concurrentScanJobs: 5
          excludeNamespaces:
            - tenant-sandbox
        # Не указывайте database, чтобы использовать базу из поставки.
        # Для независимых обновлений задайте registry и repository вместе:
        # database:
        #   registry: registry.example.com
        #   repository: security/trivy-db
        # Для обновления Java DB вне релиза задайте оба Java-параметра:
        #   javaRegistry: registry.example.com
        #   javaRepository: security/trivy-java-db
```

Где:

* `enabled` — включает Policy Manager. При значении `false` удаляются Kyverno,
  Policy Reporter, контроллер политик и сканер;
* `settings.defaultPolicySet.engines.kyverno.presets` — задает пресеты Kyverno;
* `settings.trivy.enabled` — включает сканер и адаптер отчетов отдельно от
  остальных частей Policy Manager;
* `settings.trivy.settings.scanner.reportTTL` — задает срок хранения отчета и
  эффективный интервал повторного сканирования; минимальное значение — `1s`;
* `settings.trivy.settings.scanner.concurrentScanJobs` — ограничивает количество
  одновременно выполняющихся заданий сканирования;
* `settings.trivy.settings.scanner.scanJobTimeout` — ограничивает длительность
  одного задания; минимальное значение — `1s`.