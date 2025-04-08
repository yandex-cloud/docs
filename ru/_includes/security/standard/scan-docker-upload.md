[Автоматическое сканирование](../../../container-registry/operations/scanning-docker-image.md#automatically) Docker-образов при загрузке имеет решающее значение для раннего обнаружения и устранения уязвимостей, обеспечивая безопасное развертывание контейнеров. После завершения сканирования отчеты содержат краткое описание обнаруженных уязвимостей и проблем, помогая определять приоритеты и устранять риски безопасности в контейнерных приложениях.

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** и нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Убедитесь, что сканирование Docker-образов при загрузке включено.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по сканированию Docker-образа при загрузке](../../../container-registry/operations/scanning-docker-image.md#automatically).