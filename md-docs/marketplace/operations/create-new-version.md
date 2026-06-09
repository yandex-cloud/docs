# Создание новой версии продукта

На вкладке **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_versions }}** нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_portal.marketplace_v2.version.version-table_action_create }}**. Заполните форму необходимыми сведениями:

{% note info %}

Все текстовые поля поддерживают разметку в формате [Markdown](https://ydocs.tech/ru/).

{% endnote %}

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. Загрузите логотип продукта в формате SVG.
  
  1. Выберите категории продукта.
  
  1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** выберите созданный тариф или создайте новый.
  
  1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_compute-image }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**. В открывшемся окне найдите свой каталог и выберите образ.
  
  1. Заполните информацию о продукте на русском и английском языках:
     
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-name }}** — название вашего продукта.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_short-description }}** — краткое описание.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-description }}** — подробное описание вашего продукта: какие задачи он решает, его ключевые характеристики, особенности, преимущества перед аналогами. Будьте конкретны, избегайте шаблонных рекламных формулировок.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tutorial }}** — пошаговая инструкция, как начать работу с вашим продуктом. Укажите, на что нужно обратить внимание при развертывании и трудности, с которыми может столкнуться пользователь.
     * **{{ ui-key.yacloud_portal.portal.support }}** — информация о том, как связаться с вами, если при работе с продуктом возникнут вопросы или что-то пойдет не так.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_use-cases }}** — список примеров использования вашего продукта. Оставьте ссылки на готовые примеры, если они есть.
  
  1. Добавьте полезные ссылки на русском и английском языках.
  
  1. Если требуется, уточните название и версию операционной системы. Данный блок заполняется автоматически исходя из параметров базового образа операционной системы.
  
  1. В блоке **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_packages }}** перечислите программное обеспечение с указанием версий, которое входит в продукт.
  
  1. В блоке **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_resource-spec }}**:
  
     * Задайте требования к конфигурации ВМ, необходимой для работы вашего программного продукта:
  
        1. Нажмите справа на значок ![image](../../_assets/console-icons/plus.svg).
  
        1. Выберите параметр:
           * `Доля CPU`
           * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}`
           * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_gpu }}`
           * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}`
           * `{{ ui-key.yacloud_components.acl.resource-acl.label_bindings }}`
  
             Чтобы исключить параметр, нажмите ![image](../../_assets/console-icons/xmark.svg) рядом с названием. Параметры `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_cpu }}`, `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_memory }}`, `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_disk-size }}` являются обязательными, их исключить нельзя.
  
     * Для параметров:
       
       *  `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}` — укажите максимально доступное число сетевых интерфейсов для ВМ на базе вашего продукта. По умолчанию предоставляется 1 сетевой интерфейс.
       * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}` — выберите все платформы, на которых может быть развернута ВМ.
       * `{{ ui-key.yacloud_components.acl.resource-acl.label_bindings }}` — выберите необходимые роли. Если вы укажете роль сервисного аккаунта, то при развертывании ВМ пользователю будет предложено привязать к ВМ сервисный аккаунт с этой ролью.
     * Для остальных параметров в поле **{{ ui-key.yacloud_portal.common.min }}** укажите значение, при котором гарантируется работоспособность вашего ПО на разворачиваемой ВМ. Пользователь не сможет запустить ВМ с параметрами ниже указанных. При необходимости заполните поля:
       
       * **{{ ui-key.yacloud_portal.common.max }}** — максимальное значение параметра. Пользователь не сможет запустить ВМ с параметрами выше указанных.
       * **{{ ui-key.yacloud_portal.common.recommended }}** — оптимальное значение параметра для работы вашего ПО на ВМ.
  
  1. В блоке **Условия обслуживания** добавьте ссылки на лицензионные соглашения.
     
     Для каждой ссылки заполните следующие поля:
     * **Заголовок (ru)** — название продукта (или лицензионного соглашения) на русском языке.
     * **Заголовок (en)** — название продукта (или лицензионного соглашения) на английском языке.
     * **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_type }}** — тип лицензионного соглашения:
       * для основного продукта — Дополнительные условия обслуживания;
       * для ПО других вендоров, которое входит в состав продукта - Дополнительные условия предоставления услуг третьими лицами.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tos-url }}** — ссылка на лицензионное соглашение.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ cos-name }} {#cos}

  1. Загрузите логотип продукта в формате SVG.
  
  1. Выберите категории продукта.
  
  1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** выберите созданный тариф или [создайте](create-tariff.md) новый.
  
  1. В поле **Docker compose** опишите [Docker Compose-спецификацию](../../cos/concepts/coi-specifications.md#compose-spec) в формате YAML.
  
  1. Заполните информацию о продукте на русском и английском языках:
     
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-name }}** — название вашего продукта.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_short-description }}** — краткое описание.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-description }}** — подробное описание вашего продукта: какие задачи он решает, его ключевые характеристики, особенности, преимущества перед аналогами. Будьте конкретны, избегайте шаблонных рекламных формулировок.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tutorial }}** — пошаговая инструкция, как начать работу с вашим продуктом. Укажите, на что нужно обратить внимание при развертывании и трудности, с которыми может столкнуться пользователь.
     * **{{ ui-key.yacloud_portal.portal.support }}** — информация о том, как связаться с вами, если при работе с продуктом возникнут вопросы или что-то пойдет не так.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_use-cases }}** — список примеров использования вашего продукта. Оставьте ссылки на готовые примеры, если они есть.
  
  1. Добавьте полезные ссылки на русском и английском языках.
  
  1. В блоке **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_resource-spec }}**:
  
      * Задайте требования к конфигурации ВМ, необходимой для работы вашего программного продукта:
  
          1. Нажмите справа на значок ![image](../../_assets/console-icons/plus.svg).
  
          1. Выберите параметр:
  
              * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_gpu }}`
              * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}`
              * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}`
              * `{{ ui-key.yacloud_components.acl.resource-acl.label_bindings }}`
  
              Чтобы исключить параметр, нажмите ![image](../../_assets/console-icons/xmark.svg) рядом с названием. Параметры `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_cpu }}`, `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_memory }}`, `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_disk-size }}` являются обязательными, их исключить нельзя.
  
      * Для параметров:
        
        *  `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}` — укажите максимально доступное число сетевых интерфейсов для ВМ на базе вашего продукта. По умолчанию предоставляется 1 сетевой интерфейс.
        * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}` — выберите все платформы, на которых может быть развернута ВМ.
        * `{{ ui-key.yacloud_components.acl.resource-acl.label_bindings }}` — выберите необходимые роли. Если вы укажете роль сервисного аккаунта, то при развертывании ВМ пользователю будет предложено привязать к ВМ сервисный аккаунт с этой ролью.
      * Для остальных параметров в поле **{{ ui-key.yacloud_portal.common.min }}** укажите значение, при котором гарантируется работоспособность вашего ПО на разворачиваемой ВМ. Пользователь не сможет запустить ВМ с параметрами ниже указанных. При необходимости заполните поля:
        
        * **{{ ui-key.yacloud_portal.common.max }}** — максимальное значение параметра. Пользователь не сможет запустить ВМ с параметрами выше указанных.
        * **{{ ui-key.yacloud_portal.common.recommended }}** — оптимальное значение параметра для работы вашего ПО на ВМ.
  
  1. В блоке **Условия обслуживания** добавьте ссылки на лицензионные соглашения.
     
     Для каждой ссылки заполните следующие поля:
     * **Заголовок (ru)** — название продукта (или лицензионного соглашения) на русском языке.
     * **Заголовок (en)** — название продукта (или лицензионного соглашения) на английском языке.
     * **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_type }}** — тип лицензионного соглашения:
       * для основного продукта — Дополнительные условия обслуживания;
       * для ПО других вендоров, которое входит в состав продукта - Дополнительные условия предоставления услуг третьими лицами.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tos-url }}** — ссылка на лицензионное соглашение.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ managed-k8s-name }} {#managed-k8s}

  1. Загрузите логотип продукта в формате SVG.
  
  1. Выберите категории продукта.
  
  1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** выберите созданный тариф или создайте новый.
  
  1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_k8s-manifest }}** вставьте действующую ссылку на спецификацию продукта, предварительно загруженную в {{ objstorage-full-name }}. Подробнее о спецификации и требованиям к продуктам для {{ managed-k8s-name }} см. [{#T}](../concepts/kubernetes-product.md).
  
  1. Заполните информацию о продукте на русском и английском языках:
     
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-name }}** — название вашего продукта.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_short-description }}** — краткое описание.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-description }}** — подробное описание вашего продукта: какие задачи он решает, его ключевые характеристики, особенности, преимущества перед аналогами. Будьте конкретны, избегайте шаблонных рекламных формулировок.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tutorial }}** — пошаговая инструкция, как начать работу с вашим продуктом. Укажите, на что нужно обратить внимание при развертывании и трудности, с которыми может столкнуться пользователь.
     * **{{ ui-key.yacloud_portal.portal.support }}** — информация о том, как связаться с вами, если при работе с продуктом возникнут вопросы или что-то пойдет не так.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_use-cases }}** — список примеров использования вашего продукта. Оставьте ссылки на готовые примеры, если они есть.
  
  1. Добавьте полезные ссылки на русском и английском языках.
  
  1. В блоке **Условия обслуживания** добавьте ссылки на лицензионные соглашения.
     
     Для каждой ссылки заполните следующие поля:
     * **Заголовок (ru)** — название продукта (или лицензионного соглашения) на русском языке.
     * **Заголовок (en)** — название продукта (или лицензионного соглашения) на английском языке.
     * **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_type }}** — тип лицензионного соглашения:
       * для основного продукта — Дополнительные условия обслуживания;
       * для ПО других вендоров, которое входит в состав продукта - Дополнительные условия предоставления услуг третьими лицами.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tos-url }}** — ссылка на лицензионное соглашение.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  
  ## Тестирование версии {#k8s-test}
  
  {% note warning %}
  
  Запустить версию продукта, чтобы протестировать ее работу, можно только до того, как вы нажмете кнопку **{{ ui-key.yacloud_portal.marketplace_v2.common.page_action_send-to-moderating }}** и отправите версию на модерацию.
  
  {% endnote %}
  
  Чтобы протестировать версию продукта:
  
  1. На вкладке **Версии** выберите ранее созданную версию продукта.
  1. В правом верхнем углу нажмите кнопку ![image](../../_assets/console-icons/caret-right.svg) **Запустить**.

- {{ cloud-apps-name }} {#cloud-apps}

  1. Загрузите логотип продукта в формате SVG.
  
  1. Выберите категории продукта.
  
  1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** выберите созданный тариф или [создайте](create-tariff.md) новый.
  
  1. В поле **Конфигурация** выберите конфигурацию. Если у вас нет конфигурации, [создайте](create-configuration.md) ее.
  
  1. Заполните информацию о продукте на русском и английском языках:
     
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-name }}** — название вашего продукта.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_short-description }}** — краткое описание.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-description }}** — подробное описание вашего продукта: какие задачи он решает, его ключевые характеристики, особенности, преимущества перед аналогами. Будьте конкретны, избегайте шаблонных рекламных формулировок.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tutorial }}** — пошаговая инструкция, как начать работу с вашим продуктом. Укажите, на что нужно обратить внимание при развертывании и трудности, с которыми может столкнуться пользователь.
     * **{{ ui-key.yacloud_portal.portal.support }}** — информация о том, как связаться с вами, если при работе с продуктом возникнут вопросы или что-то пойдет не так.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_use-cases }}** — список примеров использования вашего продукта. Оставьте ссылки на готовые примеры, если они есть.
  
  1. Добавьте полезные ссылки на русском и английском языках.
  
  1. В блоке **Условия обслуживания** добавьте ссылки на лицензионные соглашения.
     
     Для каждой ссылки заполните следующие поля:
     * **Заголовок (ru)** — название продукта (или лицензионного соглашения) на русском языке.
     * **Заголовок (en)** — название продукта (или лицензионного соглашения) на английском языке.
     * **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_type }}** — тип лицензионного соглашения:
       * для основного продукта — Дополнительные условия обслуживания;
       * для ПО других вендоров, которое входит в состав продукта - Дополнительные условия предоставления услуг третьими лицами.
     * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tos-url }}** — ссылка на лицензионное соглашение.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  
  После создания версии в верхнем правом углу страницы нажмите **Запустить**, чтобы протестировать развертывание приложения. Убедитесь, что все работает корректно.

{% endlist %}

Перед публикацией версия должна пройти модерацию технических специалистов и редакторов. После успешного прохождения модерации вы сможете опубликовать утвержденную версию.