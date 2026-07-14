{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. [Перейдите]({{ link-console-main }}/link/container-registry) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите нужный реестр.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** и нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Убедитесь, что сканирование Docker-образов при загрузке включено.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по сканированию Docker-образа при загрузке](../../../container-registry/operations/scanning-docker-image.md#automatically).