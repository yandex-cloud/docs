1. Загрузите логотип продукта в формате SVG.

1. Выберите категории продукта.

1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** выберите созданный тариф или создайте новый.

1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_compute-image }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**. В открывшемся окне найдите свой каталог и выберите образ.

1. {% include [product-info](product-info.md) %}

1. {% include [links](links.md) %}

1. Если требуется, уточните название и версию операционной системы. Данный блок заполняется автоматически исходя из параметров базового образа операционной системы.

1. В блоке **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_packages }}** перечислите программное обеспечение с указанием версий, которое входит в продукт.

1. В блоке **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_resource-spec }}**:

   * Задайте требования к конфигурации ВМ, необходимой для работы вашего программного продукта:

      1. Нажмите справа на значок плюс.

      1. Выберите параметр:
         * `Доля CPU`;
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}`;
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_gpu }}`;
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}`;
         * `{{ ui-key.yacloud.common.resource-acl.label_bindings }}`.
           Чтобы исключить параметр, нажмите ![image](../../_assets/console-icons/xmark.svg) рядом с названием. Параметры `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_cpu }}`, `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_memory }}`, `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_disk-size }}` являются обязательными, их исключить нельзя.

   * Для параметров:
      * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}` — выберите все платформы, на которых может быть развернута ВМ.
      * `{{ ui-key.yacloud.common.resource-acl.label_bindings }}` — выберите необходимые роли. Если вы укажете роль сервисного аккаунта, то при развертывании ВМ пользователю будет предложено привязать к ВМ сервисный аккаунт с этой ролью.
      *  `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}` — укажите максимально доступное число сетевых интерфейсов для ВМ на базе вашего продукта. По умолчанию предоставляется 1 сетевой интерфейс.
   * Для остальных параметров в поле **{{ ui-key.yacloud_portal.common.min }}** укажите значение, при котором гарантируется работоспособность вашего ПО на разворачиваемой ВМ. Пользователь не сможет запустить ВМ с параметрами ниже указанных. При необходимости заполните поля:
      * **{{ ui-key.yacloud_portal.common.max }}** — максимальное значение параметра. Пользователь не сможет запустить ВМ с параметрами выше указанных.
      * **{{ ui-key.yacloud_portal.common.recommended }}** — оптимальное значение параметра для работы вашего ПО на ВМ.

1. {% include [terms](terms.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.