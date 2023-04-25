# Сканирование Docker-образа на наличие уязвимостей

Вы можете [сканировать](../concepts/vulnerability-scanner.md) загруженные в реестр [Docker-образы](../concepts/docker-image.md) на наличие уязвимостей. Это можно делать:
* [{#T}](#manual).
* [{#T}](#automatically).

{% note warning %}

* База данных уязвимостей постоянно дополняется источниками с информацией об уязвимостях.
* Для некоторых уязвимостей не указана информация о том, в каких версиях пакетов они будут устранены. Это связано с тем, что в текущих источниках такой информации нет.
* Количество запусков сканирования Docker-образов в одном [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) [ограничено](../concepts/limits.md#container-registry-quotas).

{% endnote %}

## Вручную {#manual}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит [реестр](../concepts/registry.md), содержащий Docker-образ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр, в который загружен Docker-образ, или [создайте](registry/registry-create.md) новый и [загрузите](docker-image/docker-image-push.md) в него образ.
  1. Откройте [репозиторий](../concepts/repository.md), в котором находится Docker-образ.
  1. Нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужного Docker-образа и выберите **{{ ui-key.yacloud.cr.image.label_start-scan }}**.
  1. Дождитесь завершения сканирования. Во время его выполнения Docker-образ будет иметь статус сканирования `{{ ui-key.yacloud.cr.image.label_scan-status-RUNNING }}`, а после окончания статус сменится на `{{ ui-key.yacloud.cr.image.label_scan-status-READY }}`.
  1. Просмотрите результаты сканирования. Для этого в строке нужного Docker-образа нажмите на значение в столбце **{{ ui-key.yacloud.cr.image.label_last-scan-time }}**.

  Чтобы посмотреть запуски сканирования по Docker-образу, выберите нужный образ и перейдите на вкладку **{{ ui-key.yacloud.cr.image.label_scan-history }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [cli-install](../../_includes/default-catalogue.md) %}

  1. Получите список Docker-образов в реестре:

     ```bash
     yc container image list --repository-name=<ID реестра>/<имя Docker-образа>
     ```

     Результат:

     ```bash
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     |          ID          |       CREATED       |            NAME             |  TAGS   | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     | crpqmsqp5mtbh627i7qs | 2021-02-09 08:57:14 | crpp7p7dovf46626a7k4/ubuntu | example | 27.2 MB         |
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     ```

  1. Запустите сканирование Docker-образа:

     ```bash
     yc container image scan <ID Docker-образа>
     ```

     Результат:

     ```bash
     done (24s)
     id: che1el9t4t95elduhuq5
     image_id: crpqmsqp5mtbh627i7qs
     ...
       medium: "6"
       low: "13"
       negligible: "3"
     ```

  1. Получите детальную информацию о результатах сканирования:

     ```bash
     yc container image list-vulnerabilities --scan-result-id=<ID результатов сканирования>
     ```

     Результат:

     ```bash
     +------------+----------------+---------+-----------------+----------+---------------------------------------------------------------+
     |  SEVERITY  |      NAME      | PACKAGE |     VERSION     | FIXED BY |                             LINK                              |
     +------------+----------------+---------+-----------------+----------+---------------------------------------------------------------+
     ...
     | NEGLIGIBLE | CVE-2016-10228 | glibc   | 2.31-0ubuntu9.1 |          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10228 |
     | NEGLIGIBLE | CVE-2017-11164 | pcre3   | 2:8.39-12build1 |          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-11164 |
     | NEGLIGIBLE | CVE-2020-14155 | pcre3   | 2:8.39-12build1 |          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14155 |
     +------------+----------------+---------+-----------------+----------+---------------------------------------------------------------+
     ```

     Чтобы посмотреть запуски сканирования по Docker-образу, выполните команду:

     ```bash
     yc container image list-scan-results --repository-name=<ID реестра>/<имя Docker-образа>
     ```

     Результат:

     ```bash
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | che1el9t4t95elduhuq5 | crpqmsqp5mtbh627i7qs | 2021-03-16 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

{% endlist %}

## Автоматически {#automatically}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр или [создайте](registry/registry-create.md) новый.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}** и укажите настройки сканирования:
     * **{{ ui-key.yacloud.cr.registry.field_scan-on-upload }}** — включите автоматическое сканирование Docker-образов при загрузке в реестр.
     * **{{ ui-key.yacloud.cr.registry.label_repositories }}** — выберите один из вариантов сканирования:
       * **{{ ui-key.yacloud.cr.registry.label_all-repositories }}** — всех репозиториев реестра.
       * **{{ ui-key.yacloud.cr.registry.label_only-selected }}** — только выбранных из списка:
         1. Нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_select-repositories }}**.
         1. Укажите репозитории из списка.
         1. Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}