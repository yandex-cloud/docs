1. Просмотрите логи функции `scan-on-push` и убедитесь, что она выполнилась.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
     1. Перейдите в раздел **{{ ui-key.yacloud.serverless-functions.switch_list }}** и выберите функцию `scan-on-push`.
     1. В открывшемся окне перейдите в раздел **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** и укажите период. По умолчанию задан период за 1 час.

   - CLI {#cli}

     {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

     Посмотрите журнал выполнения функции:

     ```bash
     yc serverless function logs scan-on-push
     ```

     Результат:

     ```text
     2021-05-18 09:27:43  START RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Version: b09i2s85a0c1********
     2021-05-18 09:27:43  END RequestID: 34dc9533-ed6e-4468-b9f2-2aa0********
     2021-05-18 09:27:43  REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
     2021-05-18 09:29:25  START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Version: b09i2s85a0c1********
     2021-05-18 09:29:26  END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f********
     2021-05-18 09:29:26  REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
     ...
     ```

   {% endlist %}

1. Проверьте, что при загрузке Docker-образа запустилось новое сканирование.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр, содержащий Docker-образ.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. Выберите реестр, в который загрузили Docker-образ.
     1. Откройте репозиторий, в котором находится Docker-образ.
     1. Выберите нужный Docker-образ и проверьте значение параметра **{{ ui-key.yacloud.cr.image.label_last-scan-time }}**.

   - CLI {#cli}

     Чтобы посмотреть запуски сканирования по Docker-образу, выполните команду:

     ```bash
     yc container image list-scan-results --repository-name=<идентификатор_реестра>/<имя_Docker-образа>
     ```

     Результат:

     ```text
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | crpu20rpdc2f******** | crpqmsqp5mtb******** | 2021-05-18 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

   {% endlist %}