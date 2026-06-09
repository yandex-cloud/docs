# Требования к безопасности Kubernetes

## 7. Безопасность Kubernetes {#kubernetes-security}


[Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md) предоставляет окружение для работы с [контейнеризованными приложениями](../../glossary/containerization.md) в инфраструктуре Yandex Cloud. Вы можете разворачивать, масштабировать и управлять приложениями в контейнерах с помощью Kubernetes.

Все действия внутри узла Kubernetes являются ответственностью пользователя. Пользователь несет ответственность за безопасность узлов и их корректную настройку в соответствии с требованиями PCI DSS и других стандартов безопасности.

За безопасность API Kubernetes отвечает Yandex Cloud.

Пользователь отвечает за правильный выбор настроек безопасности Managed Service for Kubernetes, в том числе выбор [канала](../../managed-kubernetes/concepts/release-channels-and-updates.md) и расписания обновлений.

### Общее {#general}

#### 7.1 Ограничено использование критичных данных {#not-use-critical-data}

При работе с сервисом Managed Service for Kubernetes для выполнения требований PCI DSS и других стандартов безопасности запрещается:

* Использовать критичные данные в именах и описаниях кластеров, групп узлов, пространств имен, сервисов, подов.
* Использовать критичные данные в [метках узлов Kubernetes](../../managed-kubernetes/concepts/index.md#node-labels) и [метках ресурсов сервисов Yandex Cloud](../../resource-manager/concepts/labels.md).
* Указывать критичные данные в манифестах подов.
* Указывать критичные данные в etcd в открытом виде.
* Записывать критичные данные в логи Managed Service for Kubernetes.

| ID требования | Критичность |
| --- | --- |
| K8S1 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  * Убедитесь, что в именах и описаниях кластеров, групп узлов, пространств имен, сервисов, подов нет критичных данных.
  * Проверьте конфигурационные файлы на предмет критичных данных.

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен инстанс Managed Service for Kubernetes.
  1. В списке сервисов выберите **Managed Service for&nbsp;Kubernetes**.
  1. Убедитесь, что в [метках узлов Kubernetes](../../managed-kubernetes/concepts/index.md#node-labels) и [метках ресурсов сервисов Yandex Cloud](../../resource-manager/concepts/labels.md) нет критичных данных.

{% endlist %}

**Инструкции и решения по выполнению:**

Вручную исправьте названия или наполнения для манифестов и других конфигурационных файлов, если в них используются критичные данные.

#### 7.2 Ресурсы изолированы друг от друга {#maximum-isolation}

Придерживайтесь максимальной изоляции между ресурсами везде, где это возможно:

* Под каждый «большой» проект используется отдельная организация.
* Под каждую команду разработки используется отдельное облако.
* Под каждый сервис используется отдельный кластер Kubernetes в отдельном каталоге.
* Под каждый [микросервис](https://yandex.cloud/ru/blog/posts/2022/03/microservice-architecture) используется отдельное пространство имен.
* У облаков должны отсутствовать разделяемые ресурсы, у участников облаков должен быть доступ только к своему облаку.

Возможны и менее строгие схемы изоляции, например:

* Проекты развернуты в разных облаках.
* Команды разработки используют отдельные каталоги.
* Сервис представлен отдельным кластером Kubernetes.
* Микросервисы используют разные пространства имен.

| ID требования | Критичность |
| --- | --- |
| K8S2 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте, что обеспечена максимальная изоляция между ресурсами везде, где это возможно.

{% endlist %}

#### 7.3 Нет доступа к API Kubernetes и группам узлов из недоверенных сетей {#api-security}

Не рекомендуется открывать доступ к API Kubernetes и группам узлов из недоверенных сетей, в том числе из интернета. В случае необходимости используйте средства межсетевого экранирования, в частности [группы безопасности](../../vpc/concepts/security-groups.md).

| ID требования | Критичность |
| --- | --- |
| K8S3 | Средняя |

**Инструкции и решения по выполнению:**

* [Инструкция по созданию кластера без доступа в интернет](../../managed-kubernetes/tutorials/k8s-cluster-with-no-internet.md).
* [Инструкция по настройке групп безопасности](../../managed-kubernetes/operations/connect/security-groups.md).
* Используйте инструменты для настройки network policy с помощью плагинов [Calico](../../managed-kubernetes/concepts/network-policy.md#calico) (базовый) или [Cilium CNI](../../managed-kubernetes/concepts/network-policy.md#cilium) (продвинутый) в Yandex Cloud, используя `default deny` правила для входящего и исходящего трафика по умолчанию и разрешать только необходимый трафик.
* Выделите отдельный кластер Kubernetes для конечных точек, которые взаимодействуют с интернетом, либо отдельные группы узлов (с помощью механизмов: [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#:~:text=Node%20affinity%20is%20a%20property,onto%20nodes%20with%20matching%20taints) + [Node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)). Таким образом, выделяется DMZ, и в случае компрометации узлов из интернета поверхность атаки ограничится.
* Чтобы организовать входящий сетевой доступ к рабочим нагрузкам по протоколу HTTP/HTTPS используйте ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/). Существует как минимум 2 варианта Ingress-контроллера, которые можно использовать в Yandex Cloud:

  * [NGINX Ingress Controller](../../managed-kubernetes/tutorials/ingress-cert-manager.md).
  * [Application Load Balancer Ingress-контроллера](../../application-load-balancer/tools/k8s-ingress-controller/index.md).

#### 7.4 В Managed Service for Kubernetes настроены аутентификация и управление доступом {#kubernetes-auth}

Для работы кластера Kubernetes необходимы два сервисных аккаунта: [сервисный аккаунт кластера и сервисный аккаунт группы узлов](../../managed-kubernetes/security/index.md#sa-annotation). Управление доступом учетных записей IAM к ресурсам Managed Service for Kubernetes выполняется на следующих уровнях:

* Сервисные роли Managed Service for Kubernetes (доступ к Yandex Cloud API): позволяют управлять кластерами и группами узлов (например, создать кластер, создать/редактировать/удалить группу узлов и т.д.).
* Сервисные роли для доступа к Kubernetes API: позволяют управлять ресурсами кластера через Kubernetes API (например, стандартные действия с Kubernetes: создание, удаление, просмотр пространств имен, работа с подами, deployments, создание ролей и т.д.). Доступны только базовые глобальные роли на уровне всего кластера: `k8s.cluster-api.cluster-admin`, `k8s.cluster-api.editor` и `k8s.cluster-api.viewer`.
* Примитивные роли: глобальные примитивные роли IAM, которые содержат в себе сервисные роли (например, примитивная роль admin содержит в себе и сервисную административную роль и административную роль для доступа к Kubernetes API).
* Стандартные роли Kubernetes: внутри самого кластера Kubernetes доступно создание ролей и кластерных ролей средствами Kubernetes. Таким образом можно управлять доступом учетных записей IAM на уровне пространства имен. Для назначения IAM ролей на уровне пространства имен возможно вручную создавать объекты RoleBinding в необходимом пространстве имен, указывая в поле «subjects name» идентификатор IAM пользователя облака.

| ID требования | Критичность |
| --- | --- |
| K8S4 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте, что рекомендации, указанные выше, выполняются.

{% endlist %}

#### 7.5 В Managed Service for Kubernetes используется безопасная конфигурация {#kubernetes-safe-config}

В Managed Service for Kubernetes пользователь управляет всеми настройками групп узлов, настройками [мастера](../../managed-kubernetes/concepts/index.md#master) — только частично. Пользователь отвечает за безопасность всего кластера.

Для безопасной конфигурации Kubernetes, включая конфигурацию узлов, существует стандарт [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes). В Yandex Cloud группы узлов Kubernetes по умолчанию разворачиваются с конфигурацией, которая соответствует стандарту CIS Kubernetes Benchmark.

| ID требования | Критичность |
| --- | --- |
| K8S5 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  * С помощью инструмента [kube-bench](https://github.com/aquasecurity/kube-bench) проверьте конфигурацию группы узлов по стандарту CIS Kubernetes Benchmark. Инструмент официально поддерживает группы узлов Yandex Cloud.
  * [Starboard Operator](https://blog.aquasec.com/automate-kubernetes-compliance) — это бесплатный инструмент, который позволяет автоматизировать сканирование образов на уязвимости и проверку конфигурации на соответствие CIS Kubernetes Benchmark. Starboard Operator поддерживает интеграцию с kube-bench и используется для его автоматического запуска.

{% endlist %}

#### 7.6 Шифрование данных и управление секретами Managed Service for Kubernetes выполняются в формате ESO as a Service {#data-encryption}

Шифрование секретов на уровне Kubernetes etcd необходимо выполнять встроенным [механизмом сервиса Yandex Cloud](../../managed-kubernetes/concepts/encryption.md).

Работу с Kubernetes secrets рекомендуется выполнять с помощью решений класса SecretManager. В Yandex Cloud таким решением является сервис [Yandex Lockbox](../../lockbox/index.md).

Интеграция Yandex Lockbox с Kubernetes выполнена с помощью открытого проекта [External Secrets](https://external-secrets.io/latest/). Решение доступно в Cloud Marketplace в базовом упрощенном сценарии — [External Secrets Operator с поддержкой Yandex Lockbox](https://yandex.cloud/ru/marketplace/products/yc/external-secrets).

Рекомендуемый наиболее безопасный вариант шифрования секретов — ESO as a Service (External Secrets Operator as a service). При использовании ESO глобальный администратор имеет доступ к пространству имен с установленным ESO, а администраторы отдельных пространств имен создают себе объекты [SecretStore](https://external-secrets.io/latest/api/secretstore/) (в которых указывают IAM авторизованные ключи доступа к своим секретам Lockbox). В случае компрометации данного объекта SecretStore скомпрометирован будет только авторизованный ключ одного пространства имен, а не всех как в случае, например, схемы Shared ClusterSecretStore.

| ID требования | Критичность |
| --- | --- |
| K8S6 | Средняя |

**Инструкции и решения по выполнению:**

* [Инструкция по работе с External Secrets и Yandex Lockbox из описания проекта](https://external-secrets.io/latest/provider/yandex-lockbox/).
* [Инструкция по работе с External Secrets и Yandex Lockbox из документации Yandex Cloud](../../lockbox/tutorials/kubernetes-lockbox-secrets.md).

#### 7.7 Docker-образы хранятся в реестре Container Registry с настроенным периодическим сканированием образов {#docker-images-periodic-scan}

Для эффективного обеспечения безопасности рекомендуется использовать [Container Registry](../../container-registry/index.md) для хранения Docker-образов, которые разворачиваются в Managed Service for Kubernetes. Это позволит оперативно реагировать на появление новых уязвимостей в образах с помощью встроенного переодического сканирования на уязвимости.

Сканирование на уязвимости должно проводиться не реже одного раза в неделю. Это поможет своевременно обнаруживать и устранять уязвимости в образах, что существенно снизит риски несанкционированного доступа к вашим ресурсам и повысит уровень безопасности вашей инфраструктуры.

Использование Container Registry для хранения образов также обеспечит централизованное управление версиями образов, что упростит процесс обновления и управления безопасностью.

| ID требования | Критичность |
| --- | --- |
| K8S7 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **Container Registry**.
  1. Перейдите на вкладку **Сканер уязвимостей** и нажмите кнопку **Изменить настройки**.
  1. Убедитесь, что сканирование Docker-образов по расписанию включено и оно проходит не реже, чем раз в неделю.

{% endlist %}

**Инструкции и решения по выполнению:**

* [Инструкция по сканированию Docker-образа по расписанию](../../container-registry/operations/scanning-docker-image.md#scheduled).

#### 7.8 Используется одна из трех последних версий Kubernetes и ведется мониторинг обновлений {#version-update}

Для Kubernetes доступно как автоматическое, так и ручное обновление [кластера](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группы узлов](../../managed-kubernetes/concepts/index.md#node-group). Вы можете в любое время запросить обновление кластера Kubernetes или его узлов вручную до последней поддерживаемой [версии](../../managed-kubernetes/concepts/release-channels-and-updates.md). Ручные обновления обходят любые настроенные окна обслуживания и исключения обслуживания. Kubernetes регулярно выпускает обновления. Для соответствия стандартам ИБ:

* выберите подходящий канал обновления и настройте автоматическое применение обновлений, либо применяйте обновления вручную сразу после публикации в выбранном канале;
* проверьте, что настройки обновлений соответствуют стандартам ИБ;
* используйте одну из трех последних версий Kubernetes, так как любые обновления, в том числе обновления безопасности, выпускаются только для них.

| ID требования | Критичность |
| --- | --- |
| K8S8 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  Чтобы узнать список доступных версий для кластера Kubernetes:
  1. Перейдите на страницу [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Kubernetes.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. Получите список доступных версий в поле **Версия Kubernetes** блока **Конфигурация мастера**.

  Чтобы узнать список доступных версий для группы узлов Kubernetes:
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Kubernetes и перейдите на вкладку **Управление узлами**.
  1. Выберите нужную группу узлов Kubernetes в списке и нажмите кнопку **Редактировать** в правом верхнем углу.
  1. Получите список доступных версий в поле **Версия Kubernetes**.

- Проверка через CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список доступных версий, выполните команду:

  ```bash
  yc managed-kubernetes list-versions
  ```

- Проверка через API {#api}

  Чтобы получить список доступных версий, воспользуйтесь методом [list](../../managed-kubernetes/managed-kubernetes/api-ref/Version/list.md).

{% endlist %}

**Инструкции и решения по выполнению:**

* [Инструкция как обновить кластер автоматически](../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).
* [Инструкция как обновить кластер вручную](../../managed-kubernetes/operations/update-kubernetes.md#cluster-manual-upgrade).

#### 7.9 Настроено резервное копирование {#backup}

Для обеспечения непрерывности работы и защиты данных рекомендуется использовать резервное копирование в Managed Service for Kubernetes, поскольку оно позволяет быстро восстановить работу сервиса без потери данных и времени на восстановление после сбоя или аварии. Данные в [кластерах Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре Yandex Cloud. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров Kubernetes и хранить их в [Yandex Object Storage](../../storage/index.md) или другом хранилище.

| ID требования | Критичность |
| --- | --- |
| K8S9 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте наличие резервных копий данных из групп узлов кластеров Kubernetes.

{% endlist %}

**Инструкции и решения по выполнению:**

Вы можете создавать резервные копии данных из групп узлов кластера Kubernetes с помощью инструмента [Velero](https://velero.io/). Этот инструмент поддерживает работу с [дисками](../../compute/concepts/disk.md) Yandex Cloud с помощью CSI-драйвера Kubernetes, и позволяет создавать моментальные [снимки дисков томов](../../compute/concepts/snapshot.md).

При работе с Velero, установленным вручную, вы можете использовать [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальный](https://kubernetes.io/docs/concepts/storage/volumes/#local) или любой другой тип тома, в котором нет встроенной поддержки моментальных снимков. Чтобы использовать такой тип тома, задействуйте [плагин restic](https://velero.io/docs/v1.8/restic/) при установке Velero. Velero, установленный из [Cloud Marketplace](https://yandex.cloud/ru/marketplace/products/yc/velero-yc-csi), плагин restic не включает.

* [Инструкция по резервному копированию кластера Kubernetes в Object Storage](../../managed-kubernetes/tutorials/kubernetes-backup.md#backup).

#### 7.10 Используются чек-листы для безопасного создания и использования Docker-образа {#check-list}

Практики безопасного создания и использования Docker-образа необходимы для защиты от потенциальных уязвимостей, вредоносных программ и несанкционированного доступа к данным. Они помогают обеспечить целостность образа, его соответствие стандартам безопасности и предотвратить возможные угрозы при его использовании в инфраструктуре. Используйте данные чеклисты для выполнения требований по безопасному созданию образов:

* [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).
* [Kubernetes Security Checklist and Requirements](https://github.com/Vinum-Security/kubernetes-security-checklist/blob/main/README.md).

Контролировать Dockerfile в процессе [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd) можно с помощью утилиты [Conftest](https://www.conftest.dev/).

При проверке минимальных образов или образов distroless (distroless images), в которых отсутствует shell, рекомендуется использовать [ephemeral cointainers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/).

| ID требования | Критичность |
| --- | --- |
| K8S10 | Информационная |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте наличие чеклистов для выполнения требований по безопасному созданию образов.

{% endlist %}

#### 7.11 Используется политика безопасности Kubernetes {#security-standards}

Требования [Pod Security Standards от Kubernetes](https://kubernetes.io/docs/concepts/security/pod-security-standards/) позволяют предотвращать угрозы, связанные с объектами Kubernetes, такие как несанкционированный доступ к конфиденциальным данным или выполнение вредоносного кода.

Эти требования помогают обеспечить безопасность и надежность работы приложений в кластере Kubernetes. Для их реализации можно использовать встроенный инструмент Kubernetes [Pod Security Admission Controller](https://kubernetes.io/docs/setup/best-practices/enforcing-pod-security-standards/) или открытое программное обеспечение, например, [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper) или [Kyverno](https://yandex.cloud/ru/marketplace/products/yc/kyverno).

| ID требования | Критичность |
| --- | --- |
| K8S11 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте выполнение требований Pod Security Standards от Kubernetes.

{% endlist %}

**Инструкции и решения по выполнению:**

* Для контроля соответствия требованиям Pod Security Standarts также можно использовать следующие инструменты в рамках [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd):

  * [Kyverno CLI](https://kyverno.io/docs/kyverno-cli/)
  * The gator CLI

* Инструмент [Kubesec](https://kubesec.io/).

#### 7.12 Настроен сбор аудитных логов для расследований инцидентов {#audit-logs}

События, доступные пользователю в рамках сервиса Managed Service for Kubernetes, можно разделить на следующие уровни:

* события Kubernetes API (Kubernetes Audit logging);
* события узлов Kubernetes;
* события подов Kubernetes;
* метрики Kubernetes;
* Flow logs Kubernetes.

Подробнее о настройке сбора событий аудита на разных уровнях см. в разделе [Сбор, мониторинг и анализ аудитных логов Managed Service for Kubernetes](../domains/kubernetes.md#collection-monitoring-analysis-audit-logs).

Managed Service for Kubernetes предоставляет возможность проводить аудит текущей ролевой модели в сервисе. Для этого в [консоли управления](https://console.yandex.cloud) откройте страницу кластера Kubernetes и перейдите на вкладку **Управление доступом**.

Также можно использовать:

* [KubiScan](https://github.com/cyberark/KubiScan).
* [Krane](https://github.com/appvia/krane).
* [Аудитные логи](../../managed-kubernetes/at-ref.md) Yandex Audit Trails.

| ID требования | Критичность |
| --- | --- |
| K8S12 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется сбор аудитных логов.

{% endlist %}