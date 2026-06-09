# Создать окружение {{ sd-name }}

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы создать [окружение](../../concepts/workspace.md) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. Если у вас еще нет окружений, нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspacesPlaceholder.createWorkspace_8yAnK }}**.

      Если у вас уже есть окружение и вы хотите создать еще одно окружение в дополнение к уже имеющемуся, в верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и нажмите **{{ ui-key.yacloud_org.security.workspaces.WorkspacesPlaceholder.createWorkspace_8yAnK }}**.
  1. В открывшемся окне **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingPageLayout.pageTitle_ehdBw }}** в разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.generalParamsTitle_xzLoX }}**:
     
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.workspace_title_365xt }}** введите имя создаваемого окружения. Требования к имени:
     
         * длина — от 1 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
     
         При необходимости задайте краткое описание для создаваемого окружения.
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.folder_title_px1re }}** выберите каталог, в котором будут храниться ресурсы {{ sd-name }} для создаваемого окружения.
     
         В целях безопасности ресурсы {{ sd-name }} рекомендуется хранить в отдельном [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), доступ к которым есть только у сотрудников, отвечающих за безопасность.
     
         {% note info %}
     
         После создания окружения изменить выбранный каталог нельзя.
     
         {% endnote %}
     
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.billing_account_title_sU1Tj }}** привяжите платежный аккаунт, который будет использоваться для оплаты ресурсов модулей безопасности, используемых окружением.
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.alert_sink_title_pvDBG }}** выберите нужный [приемник алертов](../../concepts/workspace.md#alert-sinks), в который будут выгружаться все [алерты](../../concepts/alerts.md), сгенерированные в окружении.
        
        При необходимости создайте новый приемник алертов. Для этого нажмите кнопку **{{ ui-key.yacloud_org.security-center.alerts.sink.action_create }}**, в открывшемся окне введите имя приемника и нажмите **{{ ui-key.yacloud_org.common.create }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.createAndContinue_1yfFr }}**, чтобы перейти к следующему этапу — настройке ресурсов окружения.
  1. В открывшемся разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.resourcesTitle_fE6qp }}**:
     
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.title }}** выберите [коннектор](../../concepts/workspace.md#connectors), который будет использоваться в создаваемом окружении для доступа к контролируемым ресурсам.
     
         При необходимости создайте новый коннектор:
         
         1. Нажмите кнопку ![plug-connection](../../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud_org.security.workspaces.ConnectorAddField.addNewConnector }}** и в открывшемся окне:
         
             1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelNameField }}** укажите имя коннектора.
             1. (Опционально) В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelDescriptionField }}** задайте произвольное описание коннектора.
             1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelServiceAccountField }}** выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого будет осуществляться доступ к облачным ресурсам.
         
                 В блоке ниже вы можете посмотреть, к каким ресурсам выбранный сервисный аккаунт имеет доступ.
                 
                 Сервисному аккаунту должна быть назначена [роль](../../security/index.md#security-deck-worker) `security-deck.worker` на контролируемые в создаваемом окружении ресурсы.
         
             1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.createConnectorButton }}**.
     
     1. В появившемся блоке с коннектором нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.buttonSelectCloudCatalog }}**, чтобы выбрать ресурсы ([облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоги](../../../resource-manager/concepts/resources-hierarchy.md#folder)), безопасность в которых будет контролироваться в создаваемом окружении:
        
        1. Отметьте ресурсы, безопасность которых вы хотите контролировать в окружении. Для выбора доступны только те ресурсы, к которым есть доступ у выбранного ранее сервисного аккаунта.
        1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.saveAndContinue_9xKZY }}**.
  1. В открывшемся разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.standartsTitle_cxvJ8 }}**:
     
     1. В блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-requirements_8r7hd }}** выберите отраслевые стандарты и нормативные акты, на соответствие которым будут проверяться выбранные на предыдущем шаге ресурсы:
     
         * ![base-standard-yc](../../../_assets/security-deck/cspm-base-yc.svg) [Базовые правила безопасности облачной платформы {{ yandex-cloud }}](../../concepts/standard-compliance/yc-security-baseline.md) — минимальный набор требований безопасности, обеспечивающих базовую защиту облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}.
         * ![cspm-standard-yc](../../../_assets/security-deck/cspm-standard-yc.svg) [Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}](../../concepts/standard-compliance/yc-cloud-security-standard.md) — [стандарт](../../../security/standard/all.md) предоставляет комплексные требования безопасности и лучшие практики для защиты облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}. Эти элементы помогают обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей в облачной среде.
         * ![pci-dss-standard](../../../_assets/security-deck/cspm-pci-dss.svg) [PCI DSS](https://yandex.cloud/ru/security/standards/pci) (Payment Card Industry Data Security Standard) — стандарт безопасности данных платежных карт, включающий требования к управлению безопасностью, правилам, процедурам, сетевой архитектуре, разработке программного обеспечения и другим критически важным мерам защиты.
         * ![152-fz-standard](../../../_assets/security-deck/cspm-152-fz.svg) Требования [ФСТЭК (Приказ № 21) для защиты персональных данных](https://fstec.ru/dokumenty/vse-dokumenty/prikazy/prikaz-fstek-rossii-ot-18-fevralya-2013-g-n-21) — стандарт содержит меры по защите персональных данных от неправомерного или случайного доступа, уничтожения, изменения, блокирования, копирования, предоставления, распространения, а также от иных неправомерных действий в отношении персональных данных.
         
         * ![cspm-standard-k8s-restricted](../../../_assets/security-deck/cspm-standard-k8s-restricted.svg) {{ k8s }} Pod Security Standards (Restricted) — стандарт содержит элементы управления безопасностью на основе ограниченного профиля [{{ k8s }} Pod Security Standards (PSS) Restricted profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted). Ограниченный профиль является наиболее безопасным и обеспечивает наивысший уровень обнаружения атак на основе контейнеров. Он применяет строгие политики безопасности, которые могут потребовать модификации приложений для соответствия. Ограниченный профиль рекомендуется для критически важных с точки зрения безопасности приложений и сред, где требуется максимальная безопасность.
         * ![cspm-standard-k8s-baseline](../../../_assets/security-deck/cspm-standard-k8s-baseline.svg) {{ k8s }} Pod Security Standards (Baseline) — стандарт содержит элементы управления безопасностью на основе базового профиля стандартов безопасности [{{ k8s }} Pod Security Standards (PSS) Baseline profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline). Базовый профиль разработан для легкого внедрения и предоставляет общие лучшие практики безопасности контейнеров. Он предотвращает наиболее распространенные проблемы безопасности контейнеров, сохраняя совместимость с большинством приложений. Базовый профиль является хорошей отправной точкой для организаций, которые только начинают работать с безопасностью контейнеров.
         * ![cspm-standard-k8s-ms](../../../_assets/security-deck/cspm-standard-k8s-ms.svg) Microsoft Threat Matrix for {{ k8s }} — стандарт содержит элементы управления безопасностью на основе [Microsoft Threat Matrix for {{ k8s }}](https://www.microsoft.com/en-us/security/blog/2020/04/02/attack-matrix-kubernetes/) — фреймворка, который помогает командам безопасности понимать и защищаться от угроз, специфичных для сред {{ k8s }}. Он предоставляет комплексный взгляд на техники атак и оборонительные стратегии, адаптированные для платформ оркестрации контейнеров.
         * ![cspm-cis-k8s-standard](../../../_assets/security-deck/cspm-cis-k8s-standard.svg) CIS {{ k8s }} Benchmark — стандарт содержит рекомендации [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes) для безопасной настройки компонентов на рабочих узлах {{ k8s }}. Включает только автоматические проверки из раздела `4 Worker Nodes`.
     
         Вы можете выбрать одновременно несколько стандартов. При этом в блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** будут отображаться модули {{ sd-name }}, которые будут активированы в создаваемом окружении для проверки ресурсов на соответствие выбранным стандартам и нормативным актам.
     1. (Опционально) В блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** активируйте дополнительные модули {{ sd-name }}, необходимые вам в окружении.
        
        Например, модуль **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** не зависит от выбранных в окружении стандартов и нормативных актов, и его необходимо активировать для окружения вручную.
     1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.saveAndContinue_9xKZY }}**.
  1. (Опционально) В открывшемся разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.accessRightsTitle }}** добавьте пользователей, которым будет доступно создаваемое окружение, и назначьте им роли в этом окружении:
     
     1. Нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceParticipantsForm.action_add-user }}** и в открывшемся окне:
     
         1. Выберите нужного пользователя из списка. При необходимости воспользуйтесь строкой поиска.
         1. В открывшемся окне нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите роль, которую хотите назначить пользователю. Вы можете назначить несколько ролей.
         1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
     
     1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.finishOnboarding }}**, чтобы завершить создание окружения {{ sd-name }}.
     
     Вы можете не добавлять в окружение дополнительных пользователей. В этом случае окружение будет доступно только его создателю.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](view-dashboard.md)
* [{#T}](update.md)
* [{#T}](manage-access.md)
* [{#T}](delete.md)