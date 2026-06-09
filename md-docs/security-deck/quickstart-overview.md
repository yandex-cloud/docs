# Начало работы с {{ sd-full-name }}

Сервис {{ sd-name }} предлагает инструменты для обеспечения безопасности данных и соответствия нормативным требованиям и отраслевым стандартам.

{% note info %}

Сервис находится на стадии [Preview](../overview/concepts/launch-stages.md).

{% endnote %}

## Перед началом работы {#before-begin}

Чтобы начать работать с {{ sd-name }} в {{ yandex-cloud }}:

1. Если вы еще не зарегистрированы в {{ yandex-cloud }}, перейдите в [консоль управления]({{ link-console-main }}) и следуйте инструкциям.
1. В [сервисе {{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../resource-manager/operations/folder/create.md).
1. Убедитесь, что у вас есть необходимые [права](security/index.md) для работы с модулями {{ sd-name }}. Оптимальные роли для работы:

    * `security-deck.admin` на каталог, в котором будут храниться ресурсы {{ sd-name }} и его модули.
    * `auditor` на [организацию](../organization/concepts/organization.md), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) или каталог, безопасность в которых будет контролироваться окружением.
1. [Создайте](../iam/operations/sa/create.md) [сервисный аккаунт](../iam/concepts/users/service-accounts.md) и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роль](security/index.md#security-deck-worker) `security-deck.worker` на организацию, облако или каталог, безопасность в которых будет контролироваться окружением.

## Создайте окружение {{ sd-name }} {#create-workspace}

[Окружение](concepts/workspace.md) — это контейнер, который содержит настройки и ресурсы модулей {{ sd-name }}, перечень контролируемых ресурсов, параметры контроля и другие настройки. Окружения позволяют более гранулярно управлять безопасностью инфраструктуры в {{ yandex-cloud }}.

Чтобы создать ваше первое окружение {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![vector-circle](../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}** и нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspacesPlaceholder.createWorkspace_8yAnK }}**.
  1. В открывшемся окне **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingPageLayout.pageTitle_ehdBw }}** в разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.generalParamsTitle_xzLoX }}**:
     
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.workspace_title_365xt }}** введите имя создаваемого окружения. Требования к имени:
     
         * длина — от 1 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
     
         При необходимости задайте краткое описание для создаваемого окружения.
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.folder_title_px1re }}** выберите каталог, в котором будут храниться ресурсы {{ sd-name }} для создаваемого окружения.
     
         В целях безопасности ресурсы {{ sd-name }} рекомендуется хранить в отдельном [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), доступ к которым есть только у сотрудников, отвечающих за безопасность.
     
         {% note info %}
     
         После создания окружения изменить выбранный каталог нельзя.
     
         {% endnote %}
     
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.billing_account_title_sU1Tj }}** привяжите платежный аккаунт, который будет использоваться для оплаты ресурсов модулей безопасности, используемых окружением.
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.alert_sink_title_pvDBG }}** выберите нужный [приемник алертов](concepts/workspace.md#alert-sinks), в который будут выгружаться все [алерты](concepts/alerts.md), сгенерированные в окружении.
        
        При необходимости создайте новый приемник алертов. Для этого нажмите кнопку **{{ ui-key.yacloud_org.security-center.alerts.sink.action_create }}**, в открывшемся окне введите имя приемника и нажмите **{{ ui-key.yacloud_org.common.create }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.createAndContinue_1yfFr }}**, чтобы перейти к следующему этапу — настройке ресурсов окружения.
  1. В открывшемся разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.resourcesTitle_fE6qp }}**:
     
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.title }}** выберите [коннектор](concepts/workspace.md#connectors), который будет использоваться в создаваемом окружении для доступа к контролируемым ресурсам.
     
         При необходимости создайте новый коннектор:
         
         1. Нажмите кнопку ![plug-connection](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud_org.security.workspaces.ConnectorAddField.addNewConnector }}** и в открывшемся окне:
         
             1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelNameField }}** укажите имя коннектора.
             1. (Опционально) В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelDescriptionField }}** задайте произвольное описание коннектора.
             1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelServiceAccountField }}** выберите [сервисный аккаунт](../iam/concepts/users/service-accounts.md), от имени которого будет осуществляться доступ к облачным ресурсам.
         
                 В блоке ниже вы можете посмотреть, к каким ресурсам выбранный сервисный аккаунт имеет доступ.
                 
                 Сервисному аккаунту должна быть назначена [роль](security/index.md#security-deck-worker) `security-deck.worker` на контролируемые в создаваемом окружении ресурсы.
         
             1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.createConnectorButton }}**.
     
     1. В появившемся блоке с коннектором нажмите кнопку ![circle-plus](../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.buttonSelectCloudCatalog }}**, чтобы выбрать ресурсы ([облака](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоги](../resource-manager/concepts/resources-hierarchy.md#folder)), безопасность в которых будет контролироваться в создаваемом окружении:
        
        1. Отметьте ресурсы, безопасность которых вы хотите контролировать в окружении. Для выбора доступны только те ресурсы, к которым есть доступ у выбранного ранее сервисного аккаунта.
        1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.saveAndContinue_9xKZY }}**.
  1. В открывшемся разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.standartsTitle_cxvJ8 }}**:
     
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-requirements_8r7hd }}** выберите отраслевые стандарты и нормативные акты, на соответствие которым будут проверяться выбранные на предыдущем шаге ресурсы:
     
         * ![base-standard-yc](../_assets/security-deck/cspm-base-yc.svg) [Базовые правила безопасности облачной платформы {{ yandex-cloud }}](concepts/standard-compliance/yc-security-baseline.md) — минимальный набор требований безопасности, обеспечивающих базовую защиту облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}.
         * ![cspm-standard-yc](../_assets/security-deck/cspm-standard-yc.svg) [Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}](concepts/standard-compliance/yc-cloud-security-standard.md) — [стандарт](../security/standard/all.md) предоставляет комплексные требования безопасности и лучшие практики для защиты облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}. Эти элементы помогают обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей в облачной среде.
         * ![pci-dss-standard](../_assets/security-deck/cspm-pci-dss.svg) [PCI DSS](https://yandex.cloud/ru/security/standards/pci) (Payment Card Industry Data Security Standard) — стандарт безопасности данных платежных карт, включающий требования к управлению безопасностью, правилам, процедурам, сетевой архитектуре, разработке программного обеспечения и другим критически важным мерам защиты.
         * ![152-fz-standard](../_assets/security-deck/cspm-152-fz.svg) Требования [ФСТЭК (Приказ № 21) для защиты персональных данных](https://fstec.ru/dokumenty/vse-dokumenty/prikazy/prikaz-fstek-rossii-ot-18-fevralya-2013-g-n-21) — стандарт содержит меры по защите персональных данных от неправомерного или случайного доступа, уничтожения, изменения, блокирования, копирования, предоставления, распространения, а также от иных неправомерных действий в отношении персональных данных.
         
         * ![cspm-standard-k8s-restricted](../_assets/security-deck/cspm-standard-k8s-restricted.svg) {{ k8s }} Pod Security Standards (Restricted) — стандарт содержит элементы управления безопасностью на основе ограниченного профиля [{{ k8s }} Pod Security Standards (PSS) Restricted profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted). Ограниченный профиль является наиболее безопасным и обеспечивает наивысший уровень обнаружения атак на основе контейнеров. Он применяет строгие политики безопасности, которые могут потребовать модификации приложений для соответствия. Ограниченный профиль рекомендуется для критически важных с точки зрения безопасности приложений и сред, где требуется максимальная безопасность.
         * ![cspm-standard-k8s-baseline](../_assets/security-deck/cspm-standard-k8s-baseline.svg) {{ k8s }} Pod Security Standards (Baseline) — стандарт содержит элементы управления безопасностью на основе базового профиля стандартов безопасности [{{ k8s }} Pod Security Standards (PSS) Baseline profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline). Базовый профиль разработан для легкого внедрения и предоставляет общие лучшие практики безопасности контейнеров. Он предотвращает наиболее распространенные проблемы безопасности контейнеров, сохраняя совместимость с большинством приложений. Базовый профиль является хорошей отправной точкой для организаций, которые только начинают работать с безопасностью контейнеров.
         * ![cspm-standard-k8s-ms](../_assets/security-deck/cspm-standard-k8s-ms.svg) Microsoft Threat Matrix for {{ k8s }} — стандарт содержит элементы управления безопасностью на основе [Microsoft Threat Matrix for {{ k8s }}](https://www.microsoft.com/en-us/security/blog/2020/04/02/attack-matrix-kubernetes/) — фреймворка, который помогает командам безопасности понимать и защищаться от угроз, специфичных для сред {{ k8s }}. Он предоставляет комплексный взгляд на техники атак и оборонительные стратегии, адаптированные для платформ оркестрации контейнеров.
         * ![cspm-cis-k8s-standard](../_assets/security-deck/cspm-cis-k8s-standard.svg) CIS {{ k8s }} Benchmark — стандарт содержит рекомендации [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes) для безопасной настройки компонентов на рабочих узлах {{ k8s }}. Включает только автоматические проверки из раздела `4 Worker Nodes`.
     
         Вы можете выбрать одновременно несколько стандартов. При этом в блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** будут отображаться модули {{ sd-name }}, которые будут активированы в создаваемом окружении для проверки ресурсов на соответствие выбранным стандартам и нормативным актам.
     1. (Опционально) В блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** активируйте дополнительные модули {{ sd-name }}, необходимые вам в окружении.
        
        Например, модуль **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** не зависит от выбранных в окружении стандартов и нормативных актов, и его необходимо активировать для окружения вручную.
     1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.saveAndContinue_9xKZY }}**.
  1. (Опционально) В открывшемся разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.accessRightsTitle }}** добавьте пользователей, которым будет доступно создаваемое окружение, и назначьте им роли в этом окружении:
     
     1. Нажмите кнопку ![person-plus](../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceParticipantsForm.action_add-user }}** и в открывшемся окне:
     
         1. Выберите нужного пользователя из списка. При необходимости воспользуйтесь строкой поиска.
         1. В открывшемся окне нажмите кнопку ![plus](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите роль, которую хотите назначить пользователю. Вы можете назначить несколько ролей.
         1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
     
     1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.finishOnboarding }}**, чтобы завершить создание окружения {{ sd-name }}.
     
     Вы можете не добавлять в окружение дополнительных пользователей. В этом случае окружение будет доступно только его создателю.

{% endlist %}

## Модули {{ sd-full-name }} {#modules}

В сервис {{ sd-name }} входят следующие модули:

* [Контроль данных ({{ dspm-name }})](#dspm)
* [Контроль {{ k8s }} ({{ kspm-name }})](#kspm)
* [Диагностика доступов ({{ ciem-name }})](#ciem)
* [Контроль конфигурации ({{ cspm-name }})](#cspm)
* [{{ td-full-name }} ({{ td-name }})](#td)
* [{{ vuln-man-name }}](#vulnerability-management)
* [{{ atr-name }}](#access-transparency)
* [Портал соответствия требованиям](#compliance)

Чтобы использовать какой-либо из модулей, перейдите в [интерфейс {{ sd-name }}]({{ link-sd-main }}) и выберите нужный модуль на панели слева. На открывшейся странице вы сможете подробнее ознакомиться с возможностями инструмента и условиями его использования. Чтобы использовать выбранный модуль, выполните необходимые для его работы настройки. 

### Контроль данных ({{ dspm-name }}) {#dspm}

[Модуль контроля данных]({{ link-sd-main }}dspm/) или {{ dspm-name }} ({{ dspm-full-name }}) — это инструмент, помогающий оперативно обнаруживать чувствительную информацию, сохраненную в [бакетах](../storage/concepts/bucket.md) {{ objstorage-full-name }} и [Яндекс Дисках]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) в {{ yandex-360 }}, с тем чтобы своевременно принимать необходимые меры для ее защиты от несанкционированного доступа или утечки (настраивать [политики доступа](../storage/concepts/policy.md), обезличивать данные и т. п.).

Одна из ключевых возможностей {{ dspm-name }} — это анализ всех данных, хранящихся в бакетах в заданном окружении. [Анализ](operations/dspm/discovery-mode.md) запускается автоматически при создании окружения, сканируются все данные в бакетах. 

С помощью анализа вы можете точнее определять, в каких ресурсах могут находиться чувствительные данные, и получить готовый источник данных для последующего подробного сканирования. Поиск чувствительных данных при этом занимает меньше времени, чем сканирование источника данных, созданного вручную.

{% note info %}

Функциональность анализа данных находится на [стадии Preview](../overview/concepts/launch-stages.md) и в настоящее время не тарифицируется.

После перехода в стадию общего доступа анализ данных будет тарифицироваться отдельно от [сканирований](concepts/dspm.md#scanning) источников данных.

{% endnote %}

Чтобы начать работать с модулем {{ dspm-name }}, [активируйте](#create-workspace) его в настройках текущего [окружения](concepts/workspace.md) {{ sd-name }} и воспользуйтесь инструкциями по [анализу данных](operations/dspm/discovery-mode.md), [созданию источника данных](operations/dspm/create-data-source.md) и [созданию сканирования](operations/dspm/create-scan.md) информации.

Подробнее см. в разделе [{#T}](concepts/dspm.md).

### Контроль {{ k8s }} ({{ kspm-name }}) {#kspm}

[Контроль {{ k8s }} ({{ kspm-name }})](concepts/kspm.md) — это инструмент, позволяющий обеспечивать безопасность использования [контейнеризованных приложений](../glossary/containerization.md).

Модуль {{ kspm-name }} автоматически обнаруживает все имеющиеся в заданном [окружении](concepts/workspace.md) кластеры {{ k8s }} и контейнеры и устанавливает в них компоненты защиты в соответствии с заданной конфигурацией. Защита новых кластеров включается автоматически, без ручного поиска и установки компонентов.

Модуль обеспечивает проверку рабочей нагрузки на предмет некорректных конфигураций и контроль безопасности среды выполнения с помощью сенсоров, выявляющих атаки на узлы и контейнеры.

### Диагностика доступов ({{ ciem-name }}) {#ciem}

[Диагностика доступов]({{ link-sd-main }}iam-diagnostics/) {{ sd-name }} — это инструмент, позволяющий централизованно [просматривать](operations/ciem/view-permissions.md) полный список доступов [субъектов](../iam/concepts/access-control/index.md#subject): [пользователей](../overview/roles-and-resources.md#users), [сервисных аккаунтов](../iam/concepts/users/service-accounts.md), [групп пользователей](../organization/concepts/groups.md), [системных групп](../iam/concepts/access-control/system-group.md) и [публичных групп](../iam/concepts/access-control/public-group.md) к [ресурсам](../iam/concepts/access-control/resources-with-access-control.md) организации. Этот инструмент также позволяет легко [отзывать](operations/ciem/revoke-permissions.md) у субъектов лишние доступы. Подробнее см. в разделе [{#T}](concepts/ciem.md).

Чтобы начать работать с модулем {{ ciem-name }}, воспользуйтесь инструкциями по [просмотру](operations/ciem/view-permissions.md) и [отзыву](operations/ciem/revoke-permissions.md) доступов.

### Контроль конфигурации ({{ cspm-name }}) {#cspm}

[Контроль конфигурации ({{ cspm-name }})](concepts/cspm.md) — это инструмент, контролирующий уровень безопасности инфраструктуры на основе стандартов безопасности, таких как [Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}](../security/standard/all.md).

Контроль конфигурации ({{ cspm-name }}) в заданном [окружении](concepts/workspace.md) выполняет проверки соответствия облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}, комплексным требованиям и лучшим практикам в сфере безопасности. [Правила](concepts/cspm.md#rules) и [исключения](concepts/cspm.md#exceptions) модуля позволяют обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей в облачной среде.

### {{ td-full-name }} ({{ td-name }}) {#td}

Модуль [{{ td-full-name }} ({{ td-name }})](concepts/threat-detector.md) представляет собой первую линию защиты облачной инфраструктуры пользователя в {{ sd-full-name }} и позволяет в автоматическом режиме обнаруживать подозрительную активность и уведомлять пользователя об обнаруженных угрозах.

Модуль {{ td-full-name }} анализирует события аудита, фиксируемые в инфраструктуре клиента и регистрируемые с помощью сервиса [{{ at-full-name }}](../audit-trails/index.md). Модуль не требует настройки правил или привлечения экспертов в сфере безопасности и активируется автоматически при настройке [окружения](concepts/workspace.md) {{ sd-name }}.

При каждом срабатывании [правила](concepts/threat-detector.md#rules) на потенциальную угрозу безопасности {{ sd-name }} формирует [алерт](concepts/alerts.md) с подробной информацией о событии и советами по устранению выявленной угрозы. К анализу алерта и поиску решения по устранению вы можете привлечь AI-ассистента, который более подробно изложит суть проблемы и предложит оптимальные способы ее решения.

### {{ vuln-man-name }} {#vulnerability-management}

[Модуль управления уязвимостями]({{ link-sd-main }}vulnerability-management/) позволяет централизованно управлять сканированием контейнерных образов на уязвимости и просматривать результаты сканирований ресурсов в окружении. Модуль поддерживает сканирование образов из реестров {{ container-registry-name }} и {{ cloud-registry-name }}, а также образов, запущенных в кластерах {{ managed-k8s-name }}.

Сканирование может запускаться автоматически при загрузке образа в реестр, по расписанию или при использовании образа в кластере {{ k8s }}. Модуль интегрирован с {{ kspm-name }} для определения запущенных образов и отображения информации о том, какие образы с уязвимостями используются в проверяемом окружении.

Подробнее см. в разделе [{#T}](concepts/vulnerability-management.md).

### {{ atr-name }} {#access-transparency}

[{{ atr-name }}]({{ link-sd-main }}transparency/) — это автоматизированный инструмент, предназначенный для просмотра аналитической информации о действиях, которые инженеры {{ yandex-cloud }} производили с ресурсами организации. Такие действия могли выполняться в ходе технического обслуживания, работы с [обращениями](../support/overview.md) или решения задач безопасности.

Этот инструмент позволяет обеспечить прозрачность работы и контроль над действиями инженеров {{ yandex-cloud }}: логи их работы автоматически анализирует специально обученная модель на базе {{ yagpt-name }} и при необходимости создает эскалацию для проверки сессии специалистом по информационной безопасности {{ yandex-cloud }}.

Чтобы подключить и использовать сервис {{ atr-name }}, ваша [организация](../organization/quickstart.md) должна быть привязана к [платежному аккаунту](../billing/concepts/billing-account.md). Чтобы привязать организацию к платежному аккаунту, воспользуйтесь [инструкцией](../billing/operations/change-organization.md).

Когда к организации будет привязан платежный аккаунт, выберите его в модуле [{{ atr-name }}]({{ link-sd-main }}transparency/).

Подробнее см. в разделе [{#T}](concepts/access-transparency.md).

### Портал соответствия требованиям {#compliance}

[Портал соответствия требованиям](https://yandex.cloud/ru/security/compliance-portal) {{ sd-name }} содержит все необходимые документы, отчеты, инструкции и дополнительные сведения о системе безопасности {{ yandex-cloud }}.

Здесь вы можете как скачать публичные документы, так и запросить документы, содержащие конфиденциальные данные и доступные по запросу.

Подробнее см. в разделе [{#T}](concepts/compliance.md).

## Что дальше {#whats-next}

* Узнайте, [как посмотреть правила контроля безопасности модуля {{ cspm-name }} и их нарушения](operations/cspm/view-rules.md).
* Узнайте, [как сканировать данные в бакетах на наличие чувствительной информации](operations/dspm/create-scan.md) в {{ sd-name }}.
* Узнайте, [как просмотреть список доступов субъекта](operations/ciem/view-permissions.md) в {{ sd-name }}.
* Узнайте о [необходимых правах доступа](security/index.md) для работы с {{ sd-name }}.