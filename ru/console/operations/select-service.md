---
title: Переход в сервис и создание ресурсов
description: Следуя инструкциям на этой странице, вы сможете перейти в нужный сервис {{ yandex-cloud }} или создать ресурсы в консоли управления.
keywords:
  - Перейти в сервис {{ yandex-cloud }}
  - Открыть сервис {{ yandex-cloud }}
  - Найти сервис {{ yandex-cloud }}
  - Выбрать сервис {{ yandex-cloud }}
---

# Как начать работу с сервисами и создавать ресурсы

В консоли управления {{ yandex-cloud }} можно перейти к нужному сервису и создавать ресурсы через дашборд или панель слева.

{% include [dashboard-note](../../_includes/console/dashboard-note.md) %}

## Как открыть страницу сервиса {#select-service}

### Перейти в сервис с панели слева {#select-service-panel}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. На панели слева нажмите ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.components.AsideNavigation.label_all-services_6sGQy }}**.
  1. В строке **{{ ui-key.yacloud.dashboard.DashboardPage.CreateResourceDialog.search_kV4c1 }}** введите название сервиса.
  1. Выберите нужный сервис.

  ![image](../../_assets/console/select-service-panel.png)

### Перейти в сервис с дашборда {#select-service-dashboard}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. На панели слева нажмите ![image](../../_assets/console-icons/house.svg) **{{ ui-key.yacloud.dashboard.dashboard_j9z5M }}**.
  1. В строке **{{ ui-key.yacloud.dashboard.DashboardPage.ResourceSearch.placeholder_3my5Y }}** введите название сервиса.
  1. В разделе **{{ ui-key.yacloud.dashboard.DashboardPage.ResourcesSection.title_7kYbU }}** выберите нужный сервис.

  ![image](../../_assets/console/select-service-dashboard.png)

## Как создать ресурс {#create-resource}

### Создать ресурс на панели слева {#create-resource-panel}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. На панели слева нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.dashboard.label_create-resource_4KN3M }}**.
  1. Выберите нужный ресурс.

  ![image](../../_assets/console/create-resource-panel.png)

### Создать ресурс на дашборде {#create-resource-dashboard}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. На панели слева нажмите ![image](../../_assets/console-icons/house.svg) **{{ ui-key.yacloud.dashboard.dashboard_j9z5M }}**.
  1. Справа нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.dashboard.DashboardPage.ResourcesSection.create-resources_rGA1t }}**.
  1. Выберите нужный ресурс.

  ![image](../../_assets/console/create-resource-dashboard.png)

### Генерация кода для создания ресурса {#generate-resource-code}

При создании ресурса через консоль управления вы можете сгенерировать код для {{ TF }}, CLI или API. Код генерируется автоматически на основе параметров, выбранных в консоли управления. Ручной ввод параметров не потребуется.

Чтобы сгенерировать код для создания ресурса:

1. В [консоли управления]({{ link-console-main }}) перейдите к [созданию ресурса](#create-resource).
1. Заполните необходимые поля и нажмите кнопку ![image](../../_assets/console-icons/code.svg) **{{ ui-key.yacloud.components.Terraform.button.TerraformButton.button_terraform_ozL8u }}**.
1. В открывшемся окне выберите одну из доступных вкладок:

    {% note info %}

    Набор вкладок зависит от возможности создания данного типа ресурса в соответствующем инструменте.

    {% endnote %}

   {% list tabs %}

   - {{ TF }} {#tf}

        Выберите `{{ ui-key.yacloud.components.Terraform.TerraformDialog.button_code-terraform }}` и скопируйте команду для создания ресурса.

        Для получения информации о ресурсе провайдера [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart) нажмите `{{ ui-key.yacloud.components.Terraform.TerraformDialog.button_documentation }}`.

   - {{ yandex-cloud }} CLI {#cli}

        Выберите `{{ ui-key.yacloud.components.Terraform.TerraformDialog.button_code_cli }}` и скопируйте команду для создания ресурса.

        Для получения информации о команде [CLI](../../cli/quickstart.md) нажмите `{{ ui-key.yacloud.components.Terraform.TerraformDialog.button_documentation_cli }}`.

        {%include [move-to-cloud-shell](../../_includes/console/move-to-cloud-shell.md) %}

   - API(gRPC) {#api}

        Выберите `{{ ui-key.yacloud.components.Terraform.TerraformDialog.button_code_api_grpc }}` и скопируйте запрос на создание ресурса.

        Для получения информации о запросе к [API](../../api-design-guide/concepts/general.md) {{ yandex-cloud }} нажмите `{{ ui-key.yacloud.components.Terraform.TerraformDialog.button_documentation_api_grpc }}`.

        {%include [move-to-cloud-shell](../../_includes/console/move-to-cloud-shell.md) %}

   {% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](search.md)
* [{#T}](ai-assistant.md)
* [{#T}](cloud-shell-options.md)
