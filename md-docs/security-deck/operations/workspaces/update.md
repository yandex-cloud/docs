# Изменить окружение {{ sd-name }} и его компоненты

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

## Изменить окружение {#update-workspace}

Чтобы изменить [окружение](../../concepts/workspace.md) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.workspacesLabel_kZyU1 }}**.
  1. В открывшемся списке нажмите на нужное окружение, чтобы изменить его настройки.

      {% note tip %}

      Чтобы быстрее найти нужное окружение, воспользуйтесь фильтром.

      {% endnote %}

  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabGeneralParams_xc2v2 }}** и измените базовые параметры окружения:

      1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.workspace_title_365xt }}** измените имя и описание окружения.
      1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.alert_sink_title_pvDBG }}** выберите нужный [приемник алертов](../../concepts/workspace.md#alert-sinks), в который будут выгружаться все [алерты](../../concepts/alerts.md), сгенерированные в окружении.
         
         При необходимости создайте новый приемник алертов. Для этого нажмите кнопку **{{ ui-key.yacloud_org.security-center.alerts.sink.action_create }}**, в открывшемся окне введите имя приемника и нажмите **{{ ui-key.yacloud_org.common.create }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**, чтобы сохранить внесенные изменения.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabResources_vJuSN }}**, чтобы изменить список ресурсов, контролируемых окружением:

      1. Измените список ресурсов. Вы можете сделать это с текущими настройками [коннектора](../../concepts/workspace.md#connectors), изменив настройки коннектора или заменив коннектор на другой:

          {% list tabs %}

          - Текущие настройки

            1. В блоке с именем коннектора нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.buttonSelectCloudCatalog }}**, чтобы изменить ресурсы ([облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоги](../../../resource-manager/concepts/resources-hierarchy.md#folder)), безопасность в которых будет контролироваться в окружении. В появившемся окне:

                1. Отметьте ресурсы, безопасность которых вы хотите контролировать в окружении. Для выбора доступны только те ресурсы, к которым есть доступ у привязанного к коннектору сервисного аккаунта.
                1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.

          - Изменить настройки

            1. В блоке с именем коннектора нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.actionEditConnector }}**. В открывшемся окне:

                1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelNameField }}** измените имя коннектора.
                1. (Опционально) В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelDescriptionField }}** задайте произвольное описание коннектора.
                1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelServiceAccountField }}** измените [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого будет осуществляться доступ к облачным ресурсам.
                
                    В блоке ниже вы можете посмотреть, к каким ресурсам выбранный сервисный аккаунт имеет доступ.
                    
                    Сервисному аккаунту должна быть назначена [роль](../../security/index.md#security-deck-worker) `security-deck.worker` на контролируемые в создаваемом окружении ресурсы.
                
                1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

             1. В появившемся блоке с коннектором нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.buttonSelectCloudCatalog }}**, чтобы выбрать ресурсы ([облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоги](../../../resource-manager/concepts/resources-hierarchy.md#folder)), безопасность в которых будет контролироваться в создаваемом окружении:
                
                1. Отметьте ресурсы, безопасность которых вы хотите контролировать в окружении. Для выбора доступны только те ресурсы, к которым есть доступ у выбранного ранее сервисного аккаунта.
                1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.

          - Заменить коннектор

            1. В блоке с именем коннектора нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
            1. Нажмите на поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorAddField.addResourcesPlaceholder }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и в появившемся списке выберите нужный коннектор.

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

          {% endlist %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**, чтобы сохранить внесенные изменения.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabStandards_wSeaW }}**, чтобы изменить список стандартов, на соответствие которым будут проверяться контролируемые окружением ресурсы:

      1. В блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-requirements_8r7hd }}** выберите нужные стандарты:
      
          * ![base-standard-yc](../../../_assets/security-deck/cspm-base-yc.svg) [Базовые правила безопасности облачной платформы {{ yandex-cloud }}](../../concepts/standard-compliance/yc-security-baseline.md) — минимальный набор требований безопасности, обеспечивающих базовую защиту облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}.
          * ![cspm-standard-yc](../../../_assets/security-deck/cspm-standard-yc.svg) [Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}](../../concepts/standard-compliance/yc-cloud-security-standard.md) — [стандарт](../../../security/standard/all.md) предоставляет комплексные требования безопасности и лучшие практики для защиты облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}. Эти элементы помогают обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей в облачной среде.
          * ![pci-dss-standard](../../../_assets/security-deck/cspm-pci-dss.svg) [PCI DSS](https://yandex.cloud/ru/security/standards/pci) (Payment Card Industry Data Security Standard) — стандарт безопасности данных платежных карт, включающий требования к управлению безопасностью, правилам, процедурам, сетевой архитектуре, разработке программного обеспечения и другим критически важным мерам защиты.
          * ![152-fz-standard](../../../_assets/security-deck/cspm-152-fz.svg) Требования [ФСТЭК (Приказ № 21) для защиты персональных данных](https://fstec.ru/dokumenty/vse-dokumenty/prikazy/prikaz-fstek-rossii-ot-18-fevralya-2013-g-n-21) — стандарт содержит меры по защите персональных данных от неправомерного или случайного доступа, уничтожения, изменения, блокирования, копирования, предоставления, распространения, а также от иных неправомерных действий в отношении персональных данных.
          
          * ![cspm-standard-k8s-restricted](../../../_assets/security-deck/cspm-standard-k8s-restricted.svg) {{ k8s }} Pod Security Standards (Restricted) — стандарт содержит элементы управления безопасностью на основе ограниченного профиля [{{ k8s }} Pod Security Standards (PSS) Restricted profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted). Ограниченный профиль является наиболее безопасным и обеспечивает наивысший уровень обнаружения атак на основе контейнеров. Он применяет строгие политики безопасности, которые могут потребовать модификации приложений для соответствия. Ограниченный профиль рекомендуется для критически важных с точки зрения безопасности приложений и сред, где требуется максимальная безопасность.
          * ![cspm-standard-k8s-baseline](../../../_assets/security-deck/cspm-standard-k8s-baseline.svg) {{ k8s }} Pod Security Standards (Baseline) — стандарт содержит элементы управления безопасностью на основе базового профиля стандартов безопасности [{{ k8s }} Pod Security Standards (PSS) Baseline profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline). Базовый профиль разработан для легкого внедрения и предоставляет общие лучшие практики безопасности контейнеров. Он предотвращает наиболее распространенные проблемы безопасности контейнеров, сохраняя совместимость с большинством приложений. Базовый профиль является хорошей отправной точкой для организаций, которые только начинают работать с безопасностью контейнеров.
          * ![cspm-standard-k8s-ms](../../../_assets/security-deck/cspm-standard-k8s-ms.svg) Microsoft Threat Matrix for {{ k8s }} — стандарт содержит элементы управления безопасностью на основе [Microsoft Threat Matrix for {{ k8s }}](https://www.microsoft.com/en-us/security/blog/2020/04/02/attack-matrix-kubernetes/) — фреймворка, который помогает командам безопасности понимать и защищаться от угроз, специфичных для сред {{ k8s }}. Он предоставляет комплексный взгляд на техники атак и оборонительные стратегии, адаптированные для платформ оркестрации контейнеров.
          * ![cspm-cis-k8s-standard](../../../_assets/security-deck/cspm-cis-k8s-standard.svg) CIS {{ k8s }} Benchmark — стандарт содержит рекомендации [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes) для безопасной настройки компонентов на рабочих узлах {{ k8s }}. Включает только автоматические проверки из раздела `4 Worker Nodes`.
      
          Вы можете выбрать одновременно несколько стандартов. При этом в блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** будут добавляться модули {{ sd-name }}, которые будут активированы в создаваемом окружении для проверки ресурсов на соответствие выбранным стандартам.
      1. (Опционально) В блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** активируйте дополнительные модули {{ sd-name }}, необходимые вам в окружении.
         
         Например, модуль **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** не зависит от выбранных в окружении стандартов и нормативных актов, и его необходимо активировать для окружения вручную.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**, чтобы сохранить внесенные изменения.
  1. (Опционально) Перейдите на вкладку **Контроль Kubernetes®**, чтобы изменить настройки контроля безопасности использования кластеров {{ k8s }}.

{% endlist %}

{% note info %}

Каталог, который окружение использует для хранения своих ресурсов и настроек, изменить нельзя.

{% endnote %}

## Изменить коннектор {#update-connector}

Чтобы изменить [коннектор](../../concepts/workspace.md#connectors) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.connectorsLabel_2NoP9 }}**.

      {% note tip %}

      Чтобы быстрее найти нужный коннектор, воспользуйтесь фильтром.

      {% endnote %}

  1. В открывшемся списке в строке с нужным коннектором нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.actions.edit }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelNameField }}** измените имя коннектора.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelDescriptionField }}** задайте произвольное описание коннектора.
      1. В поле **{{ ui-key.yacloud_org.security.workspaces.ConnectorDialog.labelServiceAccountField }}** измените [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого будет осуществляться доступ к облачным ресурсам.
      
          В блоке ниже вы можете посмотреть, к каким ресурсам выбранный сервисный аккаунт имеет доступ.
          
          Сервисному аккаунту должна быть назначена [роль](../../security/index.md#security-deck-worker) `security-deck.worker` на контролируемые в создаваемом окружении ресурсы.
      
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Изменить приемник алертов {#update-alert-sink}

Чтобы изменить [приемник алертов](../../concepts/workspace.md#alert-sinks) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.alertSinkLabel_gvxBa }}**.

      {% note tip %}

      Чтобы быстрее найти нужный приемник алертов, воспользуйтесь фильтром.

      {% endnote %}
  1. В открывшемся списке в строке с нужным коннектором нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.actions.edit }}**.
  1. В открывшемся окне измените настройки приемника алертов и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](create.md)
* [{#T}](view-dashboard.md)
* [{#T}](manage-access.md)
* [{#T}](delete.md)