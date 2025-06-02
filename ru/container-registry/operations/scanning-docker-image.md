---
title: Как просканировать Docker-образ на наличие уязвимостей в {{ container-registry-full-name }}
description: Следуя данной инструкции, вы сможете просканировать Docker-образ на наличие уязвимостей.
---

# Сканирование Docker-образа на наличие уязвимостей


Вы можете [сканировать](../concepts/vulnerability-scanner.md) загруженные в [реестр](../concepts/registry.md) [Docker-образы](../concepts/docker-image.md) на наличие уязвимостей. Это можно делать:
* [Вручную](#manual).
* [При загрузке](#automatically).
* [По расписанию](#scheduled).

{% note warning %}

* База данных уязвимостей постоянно дополняется источниками с информацией об уязвимостях.
* Для некоторых уязвимостей не указана информация о том, в каких версиях пакетов они будут устранены. Это связано с тем, что в текущих источниках такой информации нет.
* Количество запусков сканирования Docker-образов в одном [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) [ограничено](../concepts/limits.md#container-registry-quotas).
* Сканирование Docker-образов на наличие уязвимостей [тарифицируется](../pricing.md#scanner).

{% endnote %}

## Вручную {#manual}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит [реестр](../concepts/registry.md), содержащий Docker-образ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр, в который загружен Docker-образ, или [создайте](registry/registry-create.md) новый и [загрузите](docker-image/docker-image-push.md) в него образ.
  1. Откройте [репозиторий](../concepts/repository.md), в котором находится Docker-образ.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного Docker-образа и выберите **{{ ui-key.yacloud.cr.image.label_start-scan }}**.
  1. Дождитесь завершения сканирования. Во время его выполнения Docker-образ будет иметь статус сканирования `{{ ui-key.yacloud.cr.registry.label_scan-status-RUNNING }}`, а после окончания статус сменится на `{{ ui-key.yacloud.cr.registry.label_scan-status-READY }}`.
  1. Просмотрите результаты сканирования. Для этого в строке нужного Docker-образа нажмите на значение в столбце **{{ ui-key.yacloud.cr.image.label_last-scan-time }}**.

  Чтобы посмотреть запуски сканирования по Docker-образу, выберите нужный образ и перейдите на вкладку **{{ ui-key.yacloud.cr.image.label_scan-history }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [cli-install](../../_includes/default-catalogue.md) %}

  1. Получите список Docker-образов в реестре:

     ```bash
     yc container image list --repository-name=<идентификатор_реестра>/<имя_Docker-образа>
     ```

     Результат:

     ```text
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     |          ID          |       CREATED       |            NAME             |  TAGS   | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     | crpqmsqp5mtb******** | 2021-02-09 08:57:14 | crpp7p7dovf4********/ubuntu | example | 27.2 MB         |
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     ```

  1. Запустите сканирование Docker-образа:

     ```bash
     yc container image scan <идентификатор_Docker-образа>
     ```

     Результат:

     ```text
     done (24s)
     id: che1el9t4t95********
     image_id: crpqmsqp5mtb********
     ...
       medium: "6"
       low: "13"
       negligible: "3"
     ```

  1. Получите детальную информацию о результатах сканирования:

     ```bash
     yc container image list-vulnerabilities --scan-result-id=<идентификатор_результатов_сканирования>
     ```

     Результат:

     ```text
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
     yc container image list-scan-results --repository-name=<идентификатор_реестра>/<имя_Docker-образа>
     ```

     Результат:

     ```text
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | che1el9t4t95******** | crpqmsqp5mtb******** | 2021-03-16 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

- API {#api}

  Чтобы сканировать Docker-образ, воспользуйтесь методом REST API [scan](../api-ref/Scanner/scan.md) для ресурса [Scanner](../api-ref/Scanner/) или вызовом gRPC API [ScannerService/Scan](../api-ref/grpc/Scanner/scan.md).

  Чтобы получить идентификатор результата сканирования `scanResultId`, воспользуйтесь методом REST API [getLast](../api-ref/Scanner/getLast) для ресурса [Scanner](../api-ref/Scanner/) или вызовом gRPC API [ScannerService/GetLast](../api-ref/grpc/Scanner/getLast.md).

  Чтобы получить детальную информацию о результатах сканирования, воспользуйтесь методом REST API [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) для ресурса [Scanner](../api-ref/Scanner/) или вызовом gRPC API [ScannerService/ListVulnerabilities](../api-ref/grpc/Scanner/listVulnerabilities.md).

{% endlist %}

## При загрузке {#automatically}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр или [создайте](registry/registry-create.md) новый.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. В блоке **{{ ui-key.yacloud.cr.registry.title_scan-on-push }}** выберите **{{ ui-key.yacloud.cr.image.label_start-scan }}** и один из вариантов сканирования:
     * `{{ ui-key.yacloud.cr.registry.label_all-repositories }}` — сканировать все репозитории реестра.
     * `{{ ui-key.yacloud.cr.registry.label_selected }}` — сканировать только выбранные репозитории:
       1. Нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_select-repositories }}**.
       1. Выберите репозитории из списка.
       1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  Чтобы автоматически сканировать Docker-образы при загрузке в реестр, воспользуйтесь методом REST API [create](../api-ref/ScanPolicy/create.md) для ресурса [ScanPolicy](../api-ref/ScanPolicy/) или вызовом gRPC API [ScanPolicyService/Create](../api-ref/grpc/ScanPolicy/create.md).

  Чтобы получить идентификатор результата сканирования `scanResultId`, воспользуйтесь методом REST API [getLast](../api-ref/Scanner/getLast) для ресурса [Scanner](../api-ref/Scanner/) или вызовом gRPC API [ScannerService/GetLast](../api-ref/grpc/Scanner/getLast.md).

  Чтобы получить детальную информацию о результатах сканирования, воспользуйтесь методом REST API [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) для ресурса [Scanner](../api-ref/Scanner/) или вызовом gRPC API [ScannerService/ListVulnerabilitiesListVulnerabilities](../api-ref/grpc/Scanner/listVulnerabilities.md).

{% endlist %}

## По расписанию {#scheduled}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр или [создайте](registry/registry-create.md) новый.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. В блоке **{{ ui-key.yacloud.cr.registry.title_scheduled-scan }}** нажмите **{{ ui-key.yacloud.cr.registry.label_add-scan-rule }}**.
  1. Выберите **{{ ui-key.yacloud.cr.image.label_start-scan }}** и один из вариантов сканирования:
     * `{{ ui-key.yacloud.cr.registry.label_all-repositories }}` — сканировать все репозитории реестра.
     * `{{ ui-key.yacloud.cr.registry.label_selected }}` — сканировать только выбранные репозитории:
       1. Нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_select-repositories }}**.
       1. Выберите репозитории из списка.
       1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Укажите, как часто хотите сканировать Docker-образы.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  Чтобы сканировать Docker-образы по расписанию, воспользуйтесь методом REST API [create](../api-ref/ScanPolicy/create.md) для ресурса [ScanPolicy](../api-ref/ScanPolicy/) или вызовом gRPC API [ScanPolicyService/Create](../api-ref/grpc/ScanPolicy/create.md).

  Чтобы получить идентификатор результата сканирования `scanResultId`, воспользуйтесь методом REST API [getLast](../api-ref/Scanner/getLast) для ресурса [Scanner](../api-ref/Scanner/) или вызовом gRPC API [ScannerService/GetLast](../api-ref/grpc/Scanner/getLast.md).

  Чтобы получить детальную информацию о результатах сканирования, воспользуйтесь методом REST API [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) для ресурса [Scanner](../api-ref/Scanner/) или вызовом gRPC API [ScannerService/ListVulnerabilitiesListVulnerabilities](../api-ref/grpc/Scanner/listVulnerabilities.md).

{% endlist %}
