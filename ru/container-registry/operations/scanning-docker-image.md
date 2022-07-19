# Сканирование Docker-образа на наличие уязвимостей

В инструкции описано, как выполнить [сканирование](../concepts/vulnerability-scanner.md) [Docker-образа](../concepts/docker-image.md) на наличие уязвимостей.

{% note warning %}

* База данных уязвимостей постоянно дополняется источниками с информацией об уязвимостях.
* Для некоторых уязвимостей не указана информация о том, в каких версиях пакетов они будут устранены. Это связано с тем, что в текущих источниках такой информации нет.
* На данный момент можно запускать сканирование вручную для Docker-образов, но планируется добавить возможность автоматического запуска сканирования.
* Количество запусков сканирования образов в одном облаке [ограничено](../concepts/limits.md#container-registry-quotas).
* Запуски сканирования уязвимостей в рамках Public Preview не тарифицируются.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр, содержащий Docker-образ.
  1. Выберите сервис **{{ container-registry-name }}**.
  1. Выберите реестр, в который загружен Docker-образ, или [создайте](registry/registry-create.md) новый и [загрузите](docker-image/docker-image-push.md) в него образ.
  1. Откройте репозиторий, в котором находится Docker-образ.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужного Docker-образа и выберите **Сканировать**.
  1. Дождитесь завершения сканирования. Во время его выполнения Docker-образ будет иметь статус сканирования `Запущено`, а после окончания статус сменится на `Готово`.
  1. Просмотрите результаты сканирования. Для этого в строке нужного Docker-образа нажмите на значение в столбце **Дата последнего сканирования**.

  Чтобы посмотреть запуски сканирования по Docker-образу, выберите нужный образ и перейдите на вкладку **История сканирований**.

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
      yc container image scan <ID образа>
      ```

      Результат:

      ```bash
      done (24s)
      id: che1el9t4t95elduhuq5
      image_id: crpqmsqp5mtbh627i7qs
      scanned_at: "2021-03-16T14:34:02.740521Z"
      status: READY
      vulnerabilities:
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
      +------------+----------------+----------+------------------------+----------------------------+---------------------------------------------------------------+
      |  SEVERITY  |      NAME      | PACKAGE  |        VERSION         |          FIXED BY          |                             LINK                              |
      +------------+----------------+----------+------------------------+----------------------------+---------------------------------------------------------------+
      | MEDIUM     | CVE-2020-27350 | apt      | 2.0.2ubuntu0.1         | 2.0.2ubuntu0.2             | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27350 |
      | MEDIUM     | CVE-2021-24031 | libzstd  | 1.4.4+dfsg-3           | 1.4.4+dfsg-3ubuntu0.1      | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-24031 |
      | MEDIUM     | CVE-2021-24032 | libzstd  | 1.4.4+dfsg-3           | 1.4.4+dfsg-3ubuntu0.1      | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-24032 |
      | MEDIUM     | CVE-2020-29361 | p11-kit  | 0.23.20-1build1        | 0.23.20-1ubuntu0.1         | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29361 |
      | MEDIUM     | CVE-2020-29362 | p11-kit  | 0.23.20-1build1        | 0.23.20-1ubuntu0.1         | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29362 |
      | MEDIUM     | CVE-2020-29363 | p11-kit  | 0.23.20-1build1        | 0.23.20-1ubuntu0.1         | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29363 |
      | LOW        | CVE-2019-18276 | bash     | 5.0-6ubuntu1.1         |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18276 |
      | LOW        | CVE-2019-25013 | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-25013 |
      | LOW        | CVE-2020-27618 | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27618 |
      | LOW        | CVE-2020-29562 | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29562 |
      | LOW        | CVE-2020-6096  | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6096  |
      | LOW        | CVE-2021-20231 | gnutls28 | 3.6.13-2ubuntu1.3      |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20231 |
      | LOW        | CVE-2021-20232 | gnutls28 | 3.6.13-2ubuntu1.3      |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20232 |
      | LOW        | CVE-2019-20838 | pcre3    | 2:8.39-12build1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20838 |
      | LOW        | CVE-2020-10543 | perl     | 5.30.0-9build1         | 5.30.0-9ubuntu0.2          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10543 |
      | LOW        | CVE-2020-10878 | perl     | 5.30.0-9build1         | 5.30.0-9ubuntu0.2          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10878 |
      | LOW        | CVE-2020-12723 | perl     | 5.30.0-9build1         | 5.30.0-9ubuntu0.2          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12723 |
      | LOW        | CVE-2013-4235  | shadow   | 1:4.8.1-1ubuntu5.20.04 |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-4235  |
      | LOW        | CVE-2019-9923  | tar      | 1.30+dfsg-7            | 1.30+dfsg-7ubuntu0.20.04.1 | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9923  |
      | NEGLIGIBLE | CVE-2016-10228 | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10228 |
      | NEGLIGIBLE | CVE-2017-11164 | pcre3    | 2:8.39-12build1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-11164 |
      | NEGLIGIBLE | CVE-2020-14155 | pcre3    | 2:8.39-12build1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14155 |
      +------------+----------------+----------+------------------------+----------------------------+---------------------------------------------------------------+
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