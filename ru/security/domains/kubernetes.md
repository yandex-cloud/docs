# Безопасность {{ k8s }}

Раздел содержит рекомендации пользователям {{ yandex-cloud }} по настройкам безопасности в [{{ managed-k8s-full-name }}](../../managed-kubernetes/).

## Разделение ответственности {#division-of-responsibility}

Все действия внутри узла {{ k8s }} являются ответственностью пользователя. Пользователь несет ответственность за безопасность узлов и их корректную настройку в соответствии с требованиями PCI DSS и других стандартов безопасности.

За безопасность API {{ k8s }} отвечает {{ yandex-cloud }}.

Пользователь отвечает за правильный выбор настроек безопасности {{ managed-k8s-short-name }}, в том числе выбор [канала](../../managed-kubernetes/concepts/release-channels-and-updates.md) и расписания обновлений.  

## Критичные данные {#critical-data}

При работе с сервисом {{ managed-k8s-short-name }} для выполнения требований PCI DSS и других стандартов безопасности запрещается:

* Использовать критичные данные в именах и описаниях кластеров, групп узлов, пространств имен, сервисов, подов.
* Использовать критичные данные в [метках узлов {{ k8s }}](../../managed-kubernetes/concepts/#node-labels) и [метках ресурсов сервисов {{ yandex-cloud }}](../../overview/concepts/services.md#labels).
* Указывать критичные данные в манифестах подов.
* Указывать критичные данные в etcd в открытом виде.
* Записывать критичные данные в логи {{ managed-k8s-short-name }}.

## Ресурсная модель {#resource-model}

Придерживайтесь максимальной изоляции между ресурсами везде, где это возможно:

* под каждый «большой» проект используется отдельная организация;
* под каждую команду разработки используется отдельное облако;
* под каждый сервис используется отдельный кластер {{ k8s }} в отдельном каталоге;
* под каждый микросервис используется отдельное пространство имен.

У облаков должны отсутствовать разделяемые ресурсы, у участников облаков должен быть доступ только к своему облаку.

Но также возможны и менее строгие схемы изоляции, например:

* Проекты отделены разными облаками.
* Команды разработки отделены отдельным каталогами.
* Сервис представлен отдельным кластером {{ k8s }}.
* Микросервисы отделены пространствами имен.

## Сетевая безопасность {{ managed-k8s-short-name }} {#network-security}

Не рекомендуется открывать доступ к API {{ k8s }} и группам узлов из недоверенных сетей, в том числе из интернета.
В случае необходимости используйте средства межсетевого экранирования, в частности [группы безопасности](../../vpc/concepts/security-groups.md). Ниже в разделе приведены ссылки на инструкции по настройке межсетевого экранирования в группах безопасности.

### Сегментация {#segmentation}

#### Уровень облака {#cloud-level}

Выполните ограничение сетевого доступа к API {{ k8s }} (мастер) и группам узлов согласно [инструкции для групп безопасности](../../managed-kubernetes/operations/connect/security-groups.md).

В случае использования ALB в качестве [Ingress Gateway](../../managed-kubernetes/tutorials/alb-ingress-controller.md) также необходимо:

1. Применить группу безопасности на ALB.
2. Дополнительно применить группу безопасности на группу узлов:

    * Тип источника: `<группа безопасности, которая применена на ALB>`.
    * Типа назначения: `группа узлов`.
    * Диапазон портов: 30000-32767.

#### Уровень {{ k8s }} {#kubernetes-level}

Выполните ограничение сетевого доступа внутри {{ k8s }} с помощью механизма [Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

В {{ yandex-cloud }} можно использовать два сетевых плагина:

* [Calico](../../managed-kubernetes/concepts/network-policy.md#calico) - базовый.
* [Cilium CNI](../../managed-kubernetes/concepts/network-policy.md#cilium) - продвинутый, использует расширенные сетевые политики [на уровне L7 (REST/HTTP, gRPC and Kafka)](https://docs.cilium.io/en/v1.10/gettingstarted/http/).

Рекомендуется использовать `default deny` правила для входящего и исходящего трафика по умолчанию и разрешать только необходимый трафик.

Для генерации политик можно использовать встроенный в Cilium CNI hubble для анализа трафика либо анализировать его вручную. Также на рынке представлены решения, которые помогают автоматически генерировать сетевые политики.

![](../../_assets/overview/solution-library-icon.svg)[Таблица сравнения решений по безопасности {{ k8s }}.](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/kubernetes-security/choice_of_solutions/Сравнение_функций_k8s_security.pdf)

Полезные примеры сетевых политик представлены в [репозитории](https://github.com/ahmetb/kubernetes-network-policy-recipes).

Полезный инструмент для создания и валидации обычных и продвинутых сетевых политик  представлен по [ссылке](https://editor.cilium.io/).

#### Организация входящего сетевого доступа {#ingress}

Рекомендуется выделить отдельный кластер {{ k8s }} для конечных точек, которые взаимодействуют с интернетом, либо отдельные группы узлов (с помощью механизмов: [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#:~:text=Node%20affinity%20is%20a%20property,onto%20nodes%20with%20matching%20taints) + [Node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)). Таким образом, выделяется DMZ, и в случае компрометации узлов из интернета поверхность атаки ограничится.

Чтобы организовать входящий сетевой доступ к рабочим нагрузкам по протоколу HTTP/HTTPS используйте ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).

Существует как минимум 2 варианта Ingress-контроллера, которые можно использовать в {{ yandex-cloud }}:
-	[NGINX Ingress Controller](../../managed-kubernetes/tutorials/ingress-cert-manager.md).
-	[{{ alb-name }} Ingress-контроллера](../../managed-kubernetes/tutorials/alb-ingress-controller.md).

Преимущества {{ alb-name }} Ingress-контроллера:
* интеграция с облачным сервисом [{{ certificate-manager-full-name }}](../../certificate-manager/);
* отсутствие необходимости установки контроллера в кластер, так как все разворачивается на стороне [{{ alb-name }}](../../application-load-balancer/)).

#### Ограничение доступа к метаданным ВМ группы узлов {#metadata-access-restriction}

Для всех подов необходимо создать network policy, которая блокирует сетевой трафик на адрес 169.254.169.254, либо использовать default-deny политику из [примера](../../managed-kubernetes/operations/calico#enable-isolation). Политика должна блокировать доступ к метаданным группы узлов из рабочих нагрузок, так как они содержат чувствительные данные, например токен сервисного аккаунта, привязанного к узлу.

## Аутентификация и управление доступом {{ managed-k8s-short-name }} {#authentication-and-access-control}

Управление доступом учетных записей {{ iam-short-name }} к ресурсам {{ managed-k8s-short-name }} выполняется на следующих уровнях:

* [Сервисные роли {{ managed-k8s-short-name }}](../../managed-kubernetes/security/#yc-api) (доступ к {{ yandex-cloud }} API): позволяют управлять кластерами и группами узлов (например, создать кластер, создать/редактировать/удалить группу узлов и т.д.).
* Сервисные роли для доступа к {{ k8s }} API: позволяют управлять ресурсами кластера через {{ k8s }} API (например, стандартные действия с {{ k8s }}: создание, удаление, просмотр пространств имен, работа с подами, deployments, создание ролей и т.д.). Доступны только базовые глобальные роли на уровне всего кластера: `k8s.cluster-api.cluster-admin`, `k8s.cluster-api.editor` и `k8s.cluster-api.viewer`.
* Примитивные роли: глобальные примитивные роли {{ iam-short-name }}, которые содержат в себе сервисные роли (например, примитивная роль admin содержит в себе и сервисную административную роль и административную роль для доступа к {{ k8s }} API).
* Стандартные роли {{ k8s }}: внутри самого кластера {{ k8s }} доступно создание ролей и кластерных ролей средствами {{ k8s }}. Таким образом можно управлять доступом учетных записей {{ iam-short-name }} на уровне пространства имен. Для назначения {{ iam-short-name }} ролей на уровне пространства имен возможно вручную создавать объекты RoleBinding в необходимом пространстве имен, указывая в поле «subjects name» идентификатор {{ iam-short-name }} пользователя облака. Пример:

    ```
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
    name: iam-user-aje0jndkhkvu04ek #имя объекта RoleBinding
    namespace: micro1-ns 
    roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: admin
    subjects:
    - kind: User
    name: aje0jndkq855llvu04ek #идентификатор пользователя облака
    ```

Для работы кластера {{ managed-k8s-short-name }} необходимы два сервисных аккаунта: [сервисный аккаунт кластера и сервисный аккаунт группы узлов](../../managed-kubernetes/security/index.md#sa-annotation).

![](../../_assets/overview/solution-library-icon.svg)[Пример настройки ролевых моделей и политик в {{ managed-k8s-short-name }}.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/auth_and_access/role-model-example)

## Безопасная конфигурация {{ managed-k8s-short-name }} {#secure-config-1}

### Безопасная конфигурация {#secure-config-2}

В {{ managed-k8s-short-name }} пользователь управляет всеми настройками групп узлов, настройками [мастера](../../managed-kubernetes/concepts/index.md#master) — только частично. Эти настройки находятся в его зоне ответственности за безопасность всего кластера.

Для безопасной конфигурации {{ k8s }}, включая конфигурацию узлов, существует стандарт [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes).

В {{ yandex-cloud }} группы узлов {{ k8s }} по умолчанию разворачиваются с конфигурацией, которая соответствует стандарту CIS {{ k8s }} Benchmark.

Инструмент [kube-bench](https://github.com/aquasecurity/kube-bench) позволяет  проверить конфигурацию группы узлов по стандарту CIS {{ k8s }} Benchmark. Инструмент официально поддерживает группы узлов {{ yandex-cloud }}.

[Здесь](https://github.com/aquasecurity/kube-bench/blob/main/docs/running.md) можно ознакомится с примерами запуска kube-bench на узлах.

Также kube-bench поддерживает интеграцию со [Starboard Operator](https://blog.aquasec.com/automate-kubernetes-compliance), другим продуктом для автоматического запуска kube-bench.

Starboard Operator — это бесплатный инструмент, который позволяет автоматизировать сканирование образов на уязвимости и проверку конфигурации на соответствие CIS {{ k8s }} Benchmark.

![](../../_assets/overview/solution-library-icon.svg) [Интеграция Starboard и {{ container-registry-full-name }} с целью сканирования запущенных образов](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/starboard_and_yc-cr)

### Контроль целостности (FIM — File integrity monitoring) {#fim}

Контроль целостности файлов на стороне группы узлов необходимо выполнять на двух уровнях:

* файлы ОС узла, например конфигурационные файлы;
* файлы контейнера, например критичные файлы, которое пользовательское приложение пишет в [том](../../managed-kubernetes/concepts/volume.md).

#### Файлы ОС узла {#fim-OS-files}

Можно использовать, например, [Osquery](https://osquery.io/) в качестве агента, который устанавливается на узлы с помощью [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) и использует конкретные каталоги узла, монтируемые как том в контейнер DaemonSet (прокинутая файловая система).

![](../../_assets/overview/solution-library-icon.svg) Комплексное решение в [Osquery and kubequery in K8s.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/osquery-kubequery)

#### Файлы контейнера {#fim-container-files}

Один из способов решения данной задачи:

1. Использовать [readOnlyRootFilesystem](https://www.thorsten-hans.com/read-only-filesystems-in-docker-and-kubernetes/) в подах.
2. Каталоги, в которые требуется записывать данные, монтировать как отдельные тома: как emptydir или как отдельные диски.

Если монтировать каталоги как emptydir, файлы будут храниться на узле в папке `/var/lib/kubelet/pods/PODUID/volumes/kubernetes.ioempty-dir/VOLUMENAME`. Данную папку можно мониторить в целях контроля целостности решением Osquery как [файлы ОС узла](#fim-OS-files).

В случае отдельных дисков (не emptydir), тома можно монтировать в режиме read к вышеупомянутому DaemonSet с Osquery.

Контроль целостности файлов узлов {{ k8s }} также можно выполнять с помощью инструментов указанных в разделе [Контроль целостности](secure-config.md#integrity-control).

Существуют специфические бесплатные решения для узлов {{ k8s }} от Google либо Argus и в том числе [file-integrity-operator](https://github.com/openshift/file-integrity-operator).

## Шифрование данных и управление секретами {{ managed-k8s-short-name }} {#encryption-and-secret-management}

Шифрование секретов на уровне {{ k8s }} etcd необходимо выполнять встроенным [механизмом сервиса {{ yandex-cloud }}](../../managed-kubernetes/concepts/encryption.md).

Работу с {{ k8s }} secrets рекомендуется выполнять с помощью решений класса SecretManager. В {{ yandex-cloud }} такое решением является сервис [{{ lockbox-name }}](../../lockbox/).

Интеграция {{ lockbox-name }} с {{ k8s }} выполнена с помощью открытого проекта [External Secrets](https://external-secrets.io/latest/). Решение доступно в {{ marketplace-name }} в базовом упрощенном сценарии — [External Secrets Operator с поддержкой Yandex Lockbox](/marketplace/products/yc/external-secrets).

Полезные инструкции по работе с External Secrets:

* [инструкция](https://external-secrets.io/latest/provider-yandex-lockbox/) по работе с External Secrets и {{ lockbox-name }} из описания проекта;
* [инструкция](../../lockbox/tutorials/kubernetes-lockbox-secrets.md) по работе с External Secrets и {{ lockbox-name }} из документации {{ yandex-cloud }}.

[Описано](https://external-secrets.io/latest/guides-multi-tenancy/#eso-as-a-service) множество способов разделения доступа к секретам в рамках данного инструмента.

Рекомендуемый наиболее безопасный вариант шифрования секретов — ESO as a Service (External Secrets Operator as a service). В таком случае глобальный администратор имеет доступ к пространству имен с установленным ESO, а администраторы отдельных пространств имен создают себе объекты [`SecretStore`](https://external-secrets.io/latest/api-secretstore/) (в которых указывают {{ iam-short-name }} авторизованные ключи доступа к своим секретам {{ lockbox-short-name }}). В случае компрометации данного объекта `SecretStore` скомпрометирован будет только авторизованный ключ одного пространства имен, а не всех как в случае, например, схемы Shared ClusterSecretStore.

### Шифрование в состоянии передачи (in transit) {#encryption-in-transist}

Для шифрования in transit рекомендуется использовать TLS-взаимодействие между подами. В случае невозможности работы по TLS используйте service mesh-решения:

* [Istio](https://istio.io/)
* [Linkerd](https://linkerd.io/)

### Шифрование в состоянии покоя (at rest) {#encryption-at-rest}

Если необходимо шифрование данных при хранении, можно использовать:

* {{ kms-name }} для шифрования данных на уровне приложения (в том числе при использовании persistent volumes).
* Свой способ организации шифрования данных, но в этом случае защита ключей и процедуры управления ключами являются полностью ответственностью пользователя.

## Защита от вредоносного кода в {{ managed-k8s-short-name }} {#malware-protection}

Защиту от вредоносного кода в {{ k8s }} можно осуществлять на двух уровнях:

* Защита уровня Container Registry;
* Защита уровня ОС узлов {{ k8s }}.

Сканер безопасности в [{{ container-registry-name }}](../../container-registry/concepts/vulnerability-scanner.md).


Чтобы защитить уровень хостов контейнеризации, можно использовать различные платные и бесплатные решения классов «Runtime security» и «Antivirus engine». Примеры бесплатных решений:

* [{{ k8s }} ClamAV](https://cloud.google.com/community/tutorials/gcp-cos-clamav)
* [Sysdig Falco](https://falco.org/) (дополнительно может выступать в роли Intrusion Detection System)

Также необходимо использовать встроенную в {{ k8s }} поддержку [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/) и [Seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/).

![](../../_assets/overview/solution-library-icon.svg)[Анализ логов безопасности {{ k8s }} в ELK: аудит-логи, policy engine, falco.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)

## Управление уязвимостями {{ managed-k8s-short-name }} {#vulnerability-management}

{{ yandex-cloud }} в рамках {{ managed-k8s-short-name }} отвечает за управление уязвимостями и обновлениями безопасности [мастера](../../managed-kubernetes/concepts/index.md#master).Пользователю необходимо самостоятельно управлять уязвимостями в рабочих узлах {{ k8s }}.

### Сканирование уязвимостей {#vulnerability-scanning}

Сканирование уязвимостей можно разбить на следующие уровни:

* сканирование уязвимостей уровня образов;
* сканирование уязвимостей ОС узлов {{ k8s }}.

Сканирование уязвимостей уровня образов описано в разделе [Защита от вредоносного кода в {{ managed-k8s-short-name }}](#malware-protection).

Примеры универсальных бесплатных решений для сканирование уязвимостей ОС узлов {{ k8s }} указаны в разделе [Сканирование уязвимостей](vulnerability-management.md#vulnerability-scanning).

Также существуют специализированные платные и бесплатные решения для сканирования уязвимостей ОС узлов {{ k8s }}, которые позволяют сканировать хосты {{ k8s }} на предмет уязвимостей, например бесплатные kube-hunter и trivi (scan filesystem).

## Обновления безопасности {#security-updates}

{{ managed-k8s-short-name }} регулярно выпускает обновления. Для соответствия стандартам ИБ:

* выберите подходящий канал обновления и настройте автоматическое применение обновлений, либо применяйте обновления вручную сразу после публикации в выбранном канале;
* проверьте, что настройки обновлений соответствуют стандартам ИБ;
* используйте одну из трех последних версий {{ k8s }}, так как любые обновления, в том числе обновления безопасности, выпускаются только для них.

## Резервное копирование и восстановление {#backup-and-restore}

Настройте резервное копирование {{ managed-k8s-short-name }} в соответствии с [руководством](../../managed-kubernetes/tutorials/backup.md). При хранении резервных копий в {{ objstorage-name }} необходимо следовать рекомендациям из раздела [Безопасная конфигурация для {{ objstorage-name }}](secure-config.md#object-storage).

## Политики безопасности {{ k8s }} {#kubernetes-security-policies}

Требования [Pod Security Standarts](https://kubernetes.io/docs/concepts/security/pod-security-standards/ ) от {{ k8s }} позволяют предотвращать угрозы, которые связаны с объектами {{ k8s }}.

Для реализации требований можно использовать либо встроенный инструмент {{ k8s }} [Pod Security Admission Controller ](https://kubernetes.io/docs/setup/best-practices/enforcing-pod-security-standards/) либо открытое программное обеспечение, например другие Admission Controllers: OPA Gatekeeper, Kyverno.

Примеры, в которых используется Kyverno:

* ![](../../_assets/overview/solution-library-icon.svg)[Анализ логов безопасности {{ k8s }} в ELK: аудит-логи, policy engine, falco.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)
* ![](../../_assets/overview/solution-library-icon.svg)[Пример настройки ролевых моделей и политик в {{ managed-k8s-short-name }}.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/auth_and_access/role-model-example)

Для контроля соответствия требованиям Pod Security Standarts также можно использовать  следующие инструменты в рамках CI/CD:

* [Kyverno CLI](https://kyverno.io/docs/kyverno-cli/)
* [The gator CLI](https://open-policy-agent.github.io/gatekeeper/website/docs/gator)

Либо отдельный инструмент [Kubesec](https://kubesec.io/).

## Практики безопасного создания и использования Docker-образа {#best-practices-docker-image}

Используйте данные чеклисты для выполнения требований по безопасному созданию образов:

* [Dockerfile best practices](https://sysdig.com/blog/dockerfile-best-practices/#2-2)
* [{{ k8s }} Security Checklist and Requirements](https://github.com/Vinum-Security/kubernetes-security-checklist/blob/main/README.md)

Контролировать Dockerfile в процессе CI/CD можно с помощью утилиты [Conftest](https://www.conftest.dev/).

## Защита runtime {#runtime-protection}

При использовании минимальных образов или образов distroless (distroless images), в которых отсутствует shell, рекомендуется использовать [ephemeral cointainers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/).

![](../../_assets/overview/solution-library-icon.svg)[Решение с использованием Osquery.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/osquery-kubequery)

## Разделение нагрузки по узлам {#load-sharing}

Нагрузки, которые имеют разные контексты безопасности (разную критичность обрабатываемых данных), необходимо обрабатывать на разных узлах {{ k8s }}. Для разделения нагрузок внутри кластера необходимо использовать разные группы узлов с разными настройками [`node labels`](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/) и [`node taints`](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). Эти настройки необходимо использовать вместе.

## Сбор, мониторинг и анализ аудитных логов {{ managed-k8s-short-name }} {#collection-monitoring-analysis-audit-logs}

События, доступные пользователю в рамках сервиса {{ managed-k8s-short-name }}, можно разделить на следующие уровни:

* события {{ k8s }} API ({{ k8s }} Audit logging);
* события узлов {{ k8s }};
* события подов {{ k8s }};
* метрики {{ k8s }};
* Flow logs {{ k8s }}.

### Уровень {{ k8s }} API ({{ k8s }} Audit logging) {#kubernetes-api-level}

Сбор событий аудита с уровня {{ k8s }} API выполняется сервисом {{ cloud-logging-name }}.

![](../../_assets/overview/solution-library-icon.svg)[Анализ логов безопасности {{ k8s }} в ELK: аудит-логи, policy engine, falco.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)

### Уровень узлов {{ k8s }} {#kubernetes-nodes-level}

Сбор и экспорт событий уровня узлов {{ k8s }} выполняется аналогично [сбору аудитных логов ОС](audit-logs#os-level).

### Уровень подов {{ k8s }} {#kubernetes-pods-level}

Сбор и экспорт событий уровня подов {{ k8s }} в различных вариантах описан в [официальной документации {{ k8s }}](https://kubernetes.io/docs/concepts/cluster-administration/logging/).

Примеры сбора и экспорта логов подов:

* Экспорт логов в {{ cloud-logging-name }} с использованием Fluent Bit описан в документации  [{{ managed-k8s-short-name }}](../../managed-kubernetes/tutorials/fluent-bit-logging.md).
* Экспорт логов подов в Elastic или Splunk рассмотрен в [Yandex Cloud Security Solution Library](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/kubernetes-security/osquery-kubequery/README_RU.md).

В {{ marketplace-name }} доступны плагин [Filebeat](/marketplace/products/yc/filebeat) для передачи логов в Elastic и [Fluent Bit с плагином {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit).

### Метрики {{ k8s }} {#kubernetes-metrics}

{{ monitoring-name }} содержит ряд метрик, применимых для анализа доступности объектов {{ k8s }} и аномалий в поведении.

Инструкция по экспорту метрик {{ monitoring-name }} приведена в разделе [Экспорт событий в SIEM](audit-logs.md#metriki-yandex-monitoring).

### Flow logs {{ k8s }} {#flow-logs-kubernetes}

![](../../_assets/overview/solution-library-icon.svg)[Экспорт flow logs в {{ objstorage-full-name }}.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/cilium-s3)

### Аудит ролевой модели {{ managed-k8s-short-name }} {#role-model-audit}

Консоль {{ managed-k8s-short-name }} предоставляет возможность проводить аудит текущей ролевой модели в сервисе. Для этого необходимо перейти во вкладку сервиса **Управление доступом**.

Также можно использовать:
* [KubiScan](https://github.com/cyberark/KubiScan)
* [Krane](https://github.com/appvia/krane)

## Сравнение решений по безопасности {{ k8s }} {#security-solutions-comparison}

![](../../_assets/overview/solution-library-icon.svg)[Сравнение решений по безопасности {{ k8s }}.](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/choice_of_solutions)