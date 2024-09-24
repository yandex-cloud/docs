# 9. Безопасность {{ k8s }}


#### Введение {#intro}

[{{ managed-k8s-full-name }}](../../../managed-kubernetes/index.yaml) предоставляет окружение для работы с [контейнеризованными приложениями](../../../glossary/containerization.md) в инфраструктуре {{ yandex-cloud }}. Вы можете разворачивать, масштабировать и управлять приложениями в контейнерах с помощью {{ k8s }}.

Все действия внутри узла {{ k8s }} являются ответственностью пользователя. Пользователь несет ответственность за безопасность узлов и их корректную настройку в соответствии с требованиями PCI DSS и других стандартов безопасности.

За безопасность API {{ k8s }} отвечает {{ yandex-cloud }}.

Пользователь отвечает за правильный выбор настроек безопасности {{ managed-k8s-name }}, в том числе выбор [канала](../../../managed-kubernetes/concepts/release-channels-and-updates.md) и расписания обновлений.

#### 9.1 Ограничено использование критичных данных {#not-use-critical-data}

При работе с сервисом {{ managed-k8s-name }} для выполнения требований PCI DSS и других стандартов безопасности запрещается:

* Использовать критичные данные в именах и описаниях кластеров, групп узлов, пространств имен, сервисов, подов.
* Использовать критичные данные в [метках узлов {{ k8s }}](../../../managed-kubernetes/concepts/index.md#node-labels) и [метках ресурсов сервисов {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md).
* Указывать критичные данные в манифестах подов.
* Указывать критичные данные в etcd в открытом виде.
* Записывать критичные данные в логи {{ managed-k8s-name }}.

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  * Убедитесь, что в именах и описаниях кластеров, групп узлов, пространств имен, сервисов, подов нет критичных данных.
  * Проверьте конфигурационные файлы на предмет критичных данных.

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен инстанс {{ managed-k8s-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Убедитесь, что в [метках узлов {{ k8s }}](../../../managed-kubernetes/concepts/index.md#node-labels) и [метках ресурсов сервисов {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md) нет критичных данных.

{% endlist %}

**Инструкции и решения по выполнению:**

Вручную исправьте названия или наполнения для манифестов и других конфигурационных файлов, если в них используются критичные данные.

#### 9.2 Ресурсы изолированы друг от друга {#maximum-isolation}

Придерживайтесь максимальной изоляции между ресурсами везде, где это возможно:

* Под каждый «большой» проект используется отдельная организация.
* Под каждую команду разработки используется отдельное облако.
* Под каждый сервис используется отдельный кластер {{ k8s }} в отдельном каталоге.
* Под каждый [микросервис](/blog/posts/2022/03/microservice-architecture) используется отдельное пространство имен.
* У облаков должны отсутствовать разделяемые ресурсы, у участников облаков должен быть доступ только к своему облаку.

Возможны и менее строгие схемы изоляции, например:

* Проекты развернуты в разных облаках.
* Команды разработки используют отдельные каталоги.
* Сервис представлен отдельным кластером {{ k8s }}.
* Микросервисы используют разные пространства имен.

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте, что обеспечена максимальная изоляция между ресурсами везде, где это возможно.

{% endlist %}

#### 9.3 Нет доступа к API {{ k8s }} и группам узлов из недоверенных сетей {#api-security}

Не рекомендуется открывать доступ к API {{ k8s }} и группам узлов из недоверенных сетей, в том числе из интернета. В случае необходимости используйте средства межсетевого экранирования, в частности [группы безопасности](../../../vpc/concepts/security-groups.md).

**Инструкции и решения по выполнению:**

* [Инструкция по созданию кластра без доступа в интернет](../../../managed-kubernetes/tutorials/k8s-cluster-with-no-internet.md).
* [Инструкция по настройке групп безопасности](../../../managed-kubernetes/operations/connect/security-groups.md).
* Используйте инструменты для настройки network policy с помощью плагинов [Calico](../../../managed-kubernetes/concepts/network-policy.md#calico) (базовый) или [Cilium CNI](../../../managed-kubernetes/concepts/network-policy.md#cilium) (продвинутый) в {{ yandex-cloud }}, используя `default deny` правила для входящего и исходящего трафика по умолчанию и разрешать только необходимый трафик.
* Выделите отдельный кластер {{ k8s }} для конечных точек, которые взаимодействуют с интернетом, либо отдельные группы узлов (с помощью механизмов: [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#:~:text=Node%20affinity%20is%20a%20property,onto%20nodes%20with%20matching%20taints) + [Node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)). Таким образом, выделяется DMZ, и в случае компрометации узлов из интернета поверхность атаки ограничится.
* Чтобы организовать входящий сетевой доступ к рабочим нагрузкам по протоколу HTTP/HTTPS используйте ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/). Существует как минимум 2 варианта Ingress-контроллера, которые можно использовать в {{ yandex-cloud }}:

  * [NGINX Ingress Controller](../../../managed-kubernetes/tutorials/ingress-cert-manager.md).
  * [Application Load Balancer Ingress-контроллера](../../../application-load-balancer/tools/k8s-ingress-controller/index.md).

#### 9.4 В {{ managed-k8s-name }} настроены аутентификация и управление доступом {#kubernetes-auth}

Для работы кластера {{ k8s }} необходимы два сервисных аккаунта: [сервисный аккаунт кластера и сервисный аккаунт группы узлов](../../../managed-kubernetes/security/index.md#sa-annotation). Управление доступом учетных записей IAM к ресурсам {{ managed-k8s-name }} выполняется на следующих уровнях:

* Сервисные роли {{ managed-k8s-name }} (доступ к {{ yandex-cloud }} API): позволяют управлять кластерами и группами узлов (например, создать кластер, создать/редактировать/удалить группу узлов и т.д.).
* Сервисные роли для доступа к {{ k8s }} API: позволяют управлять ресурсами кластера через {{ k8s }} API (например, стандартные действия с {{ k8s }}: создание, удаление, просмотр пространств имен, работа с подами, deployments, создание ролей и т.д.). Доступны только базовые глобальные роли на уровне всего кластера: `k8s.cluster-api.cluster-admin`, `k8s.cluster-api.editor` и `k8s.cluster-api.viewer`.
* Примитивные роли: глобальные примитивные роли IAM, которые содержат в себе сервисные роли (например, примитивная роль admin содержит в себе и сервисную административную роль и административную роль для доступа к {{ k8s }} API).
* Стандартные роли {{ k8s }}: внутри самого кластера {{ k8s }} доступно создание ролей и кластерных ролей средствами {{ k8s }}. Таким образом можно управлять доступом учетных записей IAM на уровне пространства имен. Для назначения IAM ролей на уровне пространства имен возможно вручную создавать объекты RoleBinding в необходимом пространстве имен, указывая в поле «subjects name» идентификатор IAM пользователя облака.

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте, что рекомендации, указанные выше, выполняются.

{% endlist %}

#### 9.5 В {{ managed-k8s-name }} используется безопасная конфигурация {#kubernetes-safe-config}

В {{ managed-k8s-name }} пользователь управляет всеми настройками групп узлов, настройками [мастера](../../../managed-kubernetes/concepts/index.md#master) — только частично. Пользователь отвечает за безопасность всего кластера.

Для безопасной конфигурации {{ k8s }}, включая конфигурацию узлов, существует стандарт [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes). В {{ yandex-cloud }} группы узлов {{ k8s }} по умолчанию разворачиваются с конфигурацией, которая соответствует стандарту CIS {{ k8s }} Benchmark.

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  * С помощью инструмента [kube-bench](https://github.com/aquasecurity/kube-bench) проверьте конфигурацию группы узлов по стандарту CIS {{ k8s }} Benchmark. Инструмент официально поддерживает группы узлов {{ yandex-cloud }}.
  * [Starboard Operator](https://blog.aquasec.com/automate-kubernetes-compliance) — это бесплатный инструмент, который позволяет автоматизировать сканирование образов на уязвимости и проверку конфигурации на соответствие CIS {{ k8s }} Benchmark. Starboard Operator поддерживает интеграцию с kube-bench и используется для его автоматического запуска.

{% endlist %}

#### 9.6 Шифрование данных и управление секретами {{ managed-k8s-name }} выполняются в формате ESO as a Service {#data-encryption}

Шифрование секретов на уровне {{ k8s }} etcd необходимо выполнять встроенным [механизмом сервиса {{ yandex-cloud }}](../../../managed-kubernetes/concepts/encryption.md).

Работу с {{ k8s }} secrets рекомендуется выполнять с помощью решений класса SecretManager. В {{ yandex-cloud }} таким решением является сервис [{{ lockbox-name }}](../../../lockbox/index.yaml).

Интеграция {{ lockbox-name }} с {{ k8s }} выполнена с помощью открытого проекта [External Secrets](https://external-secrets.io/latest/). Решение доступно в {{ marketplace-name }} в базовом упрощенном сценарии — [External Secrets Operator с поддержкой {{ lockbox-name }}](/marketplace/products/yc/external-secrets).

Рекомендуемый наиболее безопасный вариант шифрования секретов — ESO as a Service (External Secrets Operator as a service). При использовании ESO глобальный администратор имеет доступ к пространству имен с установленным ESO, а администраторы отдельных пространств имен создают себе объекты [SecretStore](https://external-secrets.io/latest/api/secretstore/) (в которых указывают IAM авторизованные ключи доступа к своим секретам {{ lockbox-short-name }}). В случае компрометации данного объекта SecretStore скомпрометирован будет только авторизованный ключ одного пространства имен, а не всех как в случае, например, схемы Shared ClusterSecretStore.

**Инструкции и решения по выполнению:**

* [Инструкция по работе с External Secrets и {{ lockbox-name }} из описания проекта](https://external-secrets.io/latest/provider/yandex-lockbox/).
* [Инструкция по работе с External Secrets и {{ lockbox-name }} из документации {{ yandex-cloud }}](https://yandex.cloud/ru/docs/lockbox/tutorials/kubernetes-lockbox-secrets).

#### 9.7 Docker-образы хранятся в реестре {{ container-registry-name }} с настроенным периодическим сканированием образов {#docker-images-periodic-scan}

Для эффективного обеспечения безопасности рекомендуется использовать [{{ container-registry-name }}](../../../container-registry/index.yaml) для хранения Docker-образов, которые разворачиваются в {{ managed-k8s-name }}. Это позволит оперативно реагировать на появление новых уязвимостей в образах с помощью встроенного переодического сканирования на уязвимости.

Сканирование на уязвимости должно проводиться не реже одного раза в неделю. Это поможет своевременно обнаруживать и устранять уязвимости в образах, что существенно снизит риски несанкционированного доступа к вашим ресурсам и повысит уровень безопасности вашей инфраструктуры.

Использование {{ container-registry-name }} для хранения образов также обеспечит централизованное управление версиями образов, что упростит процесс обновления и управления безопасностью.

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** и нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Убедитесь, что сканирование Docker-образов по расписанию включено и оно проходит не реже, чем раз в неделю.

{% endlist %}

**Инструкции и решения по выполнению:**

* [Инструкция по сканированию Docker-образа по расписанию](../../../container-registry/operations/scanning-docker-image.md#scheduled).

#### 9.8 Используется одна из трех последних версий {{ k8s }} и ведется мониторинг обновлений {#version-update}

Для {{ k8s }} доступно как автоматическое, так и ручное обновление [кластера](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группы узлов](../../../managed-kubernetes/concepts/index.md#node-group). Вы можете в любое время запросить обновление кластера {{ k8s }} или его узлов вручную до последней поддерживаемой [версии](../../../managed-kubernetes/concepts/release-channels-and-updates.md). Ручные обновления обходят любые настроенные окна обслуживания и исключения обслуживания. {{ k8s }} регулярно выпускает обновления. Для соответствия стандартам ИБ:

* выберите подходящий канал обновления и настройте автоматическое применение обновлений, либо применяйте обновления вручную сразу после публикации в выбранном канале;
* проверьте, что настройки обновлений соответствуют стандартам ИБ;
* используйте одну из трех последних версий {{ k8s }}, так как любые обновления, в том числе обновления безопасности, выпускаются только для них.

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  Чтобы узнать список доступных версий для кластера {{ k8s }}:
  1. Перейдите на страницу [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ k8s }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. Получите список доступных версий в поле **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** блока **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**.

  Чтобы узнать список доступных версий для группы узлов {{ k8s }}:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ k8s }} и перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите нужную группу узлов {{ k8s }} в списке и нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. Получите список доступных версий в поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}**.

- Проверка через CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы получить список доступных версий, выполните команду:

  ```bash
  yc managed-kubernetes list-versions
  ```

- Проверка через API {#api}

  Чтобы получить список доступных версий, воспользуйтесь методом [list](../../../managed-kubernetes/api-ref/Version/list.md).

{% endlist %}

**Инструкции и решения по выполнению:**

* [Инструкция как обновить кластер автоматически](../../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).
* [Инструкция как обновить кластер вручную](../../../managed-kubernetes/operations/update-kubernetes.md#cluster-manual-upgrade).

#### 9.9 Настроено резервное копирование {#backup}

Для обеспечения непрерывности работы и защиты данных рекомендуется использовать резервное копирование в {{ managed-k8s-name }}, поскольку оно позволяет быстро восстановить работу сервиса без потери данных и времени на восстановление после сбоя или аварии. Данные в [кластерах {{ k8s }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../../../managed-kubernetes/concepts/index.md#node-group) кластеров {{ k8s }} и хранить их в [{{ objstorage-full-name }}](../../../storage/index.yaml) или другом хранилище.

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте наличие резервных копий данных из групп узлов кластеров {{ k8s }}.

{% endlist %}

**Инструкции и решения по выполнению:**

Вы можете создавать резервные копии данных из групп узлов кластера {{ k8s }} с помощью инструмента [Velero](https://velero.io/). Этот инструмент поддерживает работу с [дисками](../../../compute/concepts/disk.md) {{ yandex-cloud }} с помощью CSI-драйвера {{ k8s }}, и позволяет создавать моментальные [снимки дисков томов](../../../compute/concepts/snapshot.md).

При работе с Velero, установленным вручную, вы можете использовать [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальный](https://kubernetes.io/docs/concepts/storage/volumes/#local) или любой другой тип тома, в котором нет встроенной поддержки моментальных снимков. Чтобы использовать такой тип тома, задействуйте [плагин restic](https://velero.io/docs/v1.8/restic/) при установке Velero. Velero, установленный из [{{ marketplace-name }}](/marketplace/products/yc/velero-yc-csi), плагин restic не включает.

* [Инструкция по резервному копированию кластера {{ k8s }} в {{ objstorage-name }}](../../../managed-kubernetes/tutorials/kubernetes-backup.md#backup).

#### 9.10 Используются чек-листы для безопасного создания и использования Docker-образа {#check-list}

Практики безопасного создания и использования Docker-образа необходимы для защиты от потенциальных уязвимостей, вредоносных программ и несанкционированного доступа к данным. Они помогают обеспечить целостность образа, его соответствие стандартам безопасности и предотвратить возможные угрозы при его использовании в инфраструктуре. Используйте данные чеклисты для выполнения требований по безопасному созданию образов:

* [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).
* [{{ k8s }} Security Checklist and Requirements](https://github.com/Vinum-Security/kubernetes-security-checklist/blob/main/README.md).

Контролировать Dockerfile в процессе [CI/CD](/blog/posts/2022/10/ci-cd) можно с помощью утилиты [Conftest](https://www.conftest.dev/).

При проверке минимальных образов или образов distroless (distroless images), в которых отсутствует shell, рекомендуется использовать [ephemeral cointainers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/).

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте наличие чеклистов для выполнения требований по безопасному созданию образов.

{% endlist %}

#### 9.11 Используется политика безопасности {{ k8s }} {#security-standards}

Требования [Pod Security Standards от {{ k8s }}](https://kubernetes.io/docs/concepts/security/pod-security-standards/) позволяют предотвращать угрозы, связанные с объектами {{ k8s }}, такие как несанкционированный доступ к конфиденциальным данным или выполнение вредоносного кода.

Эти требования помогают обеспечить безопасность и надежность работы приложений в кластере {{ k8s }}. Для их реализации можно использовать встроенный инструмент {{ k8s }} [Pod Security Admission Controller ](https://kubernetes.io/docs/setup/best-practices/enforcing-pod-security-standards/) или открытое программное обеспечение, например, [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper) или [Kyverno](/marketplace/products/yc/kyverno).

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте выполнение требований Pod Security Standards от {{ k8s }}.

{% endlist %}

**Инструкции и решения по выполнению:**

* Для контроля соответствия требованиям Pod Security Standarts также можно использовать следующие инструменты в рамках [CI/CD](/blog/posts/2022/10/ci-cd):

  * [Kyverno CLI](https://kyverno.io/docs/kyverno-cli/)
  * The gator CLI

* Инструмент [Kubesec](https://kubesec.io/).

#### 9.12 Настроен сбор аудитных логов для расследований инцидентов {#audit-logs}

События, доступные пользователю в рамках сервиса {{ managed-k8s-name }}, можно разделить на следующие уровни:

* события {{ k8s }} API ({{ k8s }} Audit logging);
* события узлов {{ k8s }};
* события подов {{ k8s }};
* метрики {{ k8s }};
* Flow logs {{ k8s }}.

Подробнее о настройке сбора событий аудита на разных уровнях см. в разделе [{#T}](../../../security/domains/kubernetes.md#collection-monitoring-analysis-audit-logs).

{{ managed-k8s-name }} предоставляет возможность проводить аудит текущей ролевой модели в сервисе. Для этого в [консоли управления]({{ link-console-main }}) откройте страницу кластера {{ k8s }} и перейдите на вкладку **{{ ui-key.yacloud.k8s.access.label_title }}**.

Также можно использовать:

* [KubiScan](https://github.com/cyberark/KubiScan).
* [Krane](https://github.com/appvia/krane).
* [Аудитные логи](../../../managed-kubernetes/at-ref.md) {{ at-full-name }}.

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется сбор аудитных логов.

{% endlist %}

