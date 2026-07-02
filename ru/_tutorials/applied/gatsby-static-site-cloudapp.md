# Установка Gatsby с помощью {{ cloud-apps-name }}


С помощью этого руководства вы установите и настроите статический сайт на [Gatsby](https://www.gatsbyjs.com/) — фреймворке для создания статических и гибридных сайтов — используя сервис [{{ cloud-apps-name }}](../../cloud-apps/). Приложение развернет сайт в [{{ objstorage-name }}](../../storage/) и настроит доступ по домену с автоматическим выпуском SSL-сертификатов.

{% include [static-site-sc-note](../../_includes/tutorials/static-site-sc-note.md) %}

Чтобы установить Gatsby:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте DNS-зону](#configure-dns).
1. [Установите Gatsby с помощью {{ cloud-apps-name }}](#install-gatsby).
1. [Подготовьте репозиторий сайта](#prepare-repo).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* плата за использование публичной DNS-зоны и за публичные DNS-запросы ([тарифы {{ dns-full-name }}](../../dns/pricing.md));
* плата за хранение данных в {{ objstorage-full-name }}, операции с ними и исходящий трафик ([тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за хранение секретов в {{ lockbox-name }} ([тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).

## Настройте DNS-зону {#configure-dns}

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}

## Установите Gatsby с помощью {{ cloud-apps-name }} {#install-gatsby}

Установите [статический сайт](marketplace/products/yc/static-site) на Gatsby с помощью {{ cloud-apps-name }}. Приложение развернет сайт в [{{ objstorage-name }}](../../storage/) и настроит доступ по домену.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/cloud-apps/) в сервис {{ cloud-apps-name }}.  
  1. Нажмите кнопку **{{ ui-key.yacloud.cloud-apps.button_install-application }}**.
  1. Выберите приложение **Статический сайт в {{ objstorage-name }}**.
  1. Задайте параметры приложения:

      #|
      || **Параметр** | **Обязательный** | **Значение по умолчанию** | **Описание** ||
      || **{{ ui-key.yacloud.common.name }}** | Да | — | Название экземпляра приложения. ||
      || **{{ ui-key.yacloud.common.description }}** | — | — | Описание экземпляра приложения. ||
      || **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** | Да | — | Сервисный аккаунт, от имени которого будет происходить установка приложения. Сервисный аккаунт должен иметь роли `storage.admin`, `lockbox.admin`, `certificate-manager.admin` и `dns.admin` на каталог.
      Чтобы сервисный аккаунт с необходимыми правами создался во время установки приложения, выберите `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`. ||
      || **DNS-зона** | Да | — | Идентификатор DNS-зоны, в которой будет находиться домен сайта. ||
      || **Поддомен** | — | Пустой | Домен, на котором будет доступен статический сайт на Gatsby. Формируется добавлением поддомена к домену DNS-зоны: `site.example.com` или `example.com`, если поддомен не указан. ||
      || **Конфигурация веб-сайта** | Да | — | Выберите в выпадающем списке `Gatsby`. ||
      || **Максимальный размер бакета** | — | `10` | Максимальный размер бакета {{ objstorage-name }} для статических файлов сайта в ГБ. ||
      |#

  1. Нажмите кнопку **{{ ui-key.yacloud.cloud-apps.button_install }}**.

     Установка приложения займет несколько минут. В процессе установки будут созданы бакет в {{ objstorage-name }}, записи в DNS-зоне для поддомена сайта и необходимые ресурсы для доступа по HTTPS. Дождитесь завершения установки.

{% endlist %}

## Подготовьте репозиторий {#prepare-repo}

После установки приложения подготовьте репозиторий в {{ src-name }} с исходным кодом сайта:

1. Если у вас еще не установлен Git, установите его по [инструкции](https://git-scm.com/book/ru/v2/Введение-Установка-Git).

1. [Создайте]({{ link-src-docs }}/sourcecraft/operations/repo-create#create-from-template) репозиторий из [шаблона `cloudapp-gatsby`](https://sourcecraft.dev/yandex-cloud-examples/cloudapp-gatsby).

1. На локальном компьютере перейдите в рабочую директорию, где будет размещен проект сайта.

1. [Клонируйте]({{ link-src-docs }}/sourcecraft/operations/repo-clone) репозиторий, созданный из шаблона.

1. Перейдите в склонированный репозиторий. Дальнейшую работу (настройку окружения, сборку и выгрузку) выполняйте внутри этого каталога.

## Разверните сайт {#deploy-site}

Откройте файл `README` в корне репозитория и выполните описанные там шаги:

1. [Настройте]({{ link-src-docs }}/sourcecraft/operations/service-connections) сервисное подключение. Укажите сервисный аккаунт, созданный при установке приложения.
      
   Имя сервисного подключения, заданное при его создании, потребуется для дальнейшей настройки.

1. Обновите конфигурационные файлы в редакторе, например в Visual Studio Code:

   1. Файл `gatsby-config.ts`:

      ```typescript
       const config: GatsbyConfig = {
        siteMetadata: {
          title: `<название_сайта>`,
          siteUrl: `https://<домен>`,
        },
        // ...
        plugins: [
          {
            resolve: `gatsby-plugin-s3`,
            options: {
              bucketName: "<имя_бакета>",
              region: "ru-central1",
              protocol: "https",
              hostname: "storage.yandexcloud.net",
              customAwsEndpointHostname: 'storage.yandexcloud.net'
            },
          }
        ],
      }
      ```

      Где:
      * `<название_сайта>` — название вашего сайта.
      * `<домен>` — домен, на котором будет доступен сайт. Обычно совпадает с именем бакета, созданного при установке приложения.
      * `<имя_бакета>` — имя бакета, автоматически созданного во время установки приложения.

   1. Файл `.sourcecraft/ci.yaml`:

      ```yaml
      tokens:
        SERVICE_CONNECTION:
          service_connection: <сервисное_подключение>
          scope: org

      workflows:
        gatsby-deploy:
          env:
            DOMAIN_NAME: <домен>
      ```

      Где:
      * `<сервисное_подключение>` — имя сервисного подключения.
      * `<домен>` — домен, на котором будет доступен сайт. Обычно совпадает с именем бакета, созданного при установке приложения.
      * `scope` — уровень сервисного подключения. Возможные значения:
         * `repo` — для подключений на уровне репозитория.
         * `org` — для подключений на уровне организации.

1. Запустите пайплайн CI/CD для развертывания статического сайта. Для этого последовательно выполните команды в ветку `main`:

   ```bash
   git commit -a
   ```

   Введите название коммита.

   ```bash
   git push
   ```

   После успешного выполнения пайплайна сайт станет доступен по адресу `https://<домен>`. Результат сборки автоматически загрузится в бакет {{ objstorage-name }}.

## Настройте сайт {#configure-site}

1. Установите [Node.js](https://nodejs.org/) нужной версии для локальной разработки.

1. Установите зависимости проекта:

   ```bash
   npm install
   ```

1. Запустите dev-сервер:

   ```bash
   npm run develop
   ```

   Сайт будет доступен по адресу `http://localhost:8000`.

1. Для сборки продакшен-версии выполните команду:

   ```bash
   npm run build
   ```

1. Для локального просмотра продакшен-сборки выполните команду:

   ```bash
   npm run serve
   ```
1. Чтобы опубликовать изменения, запустите пайплайн CI/CD, как описано в разделе [{#T}](#deploy-site).

## Проверьте результат {#check-result}

Убедитесь, что ваш статический сайт на Gatsby успешно опубликован и доступен по публичному домену:

1. Откройте в браузере домен или поддомен, который указывали при установке приложения (например, `https://site.example.com`).

1. Проверьте, что открывается главная страница вашего Gatsby-сайта и работает его навигация.

1. Если в шаблоне была добавлена тестовая страница или раздел, перейдите по соответствующей ссылке и убедитесь, что она также открывается по публичному URL.

Если сайт открывается, все изображения, стили и страницы загружаются корректно — развертывание выполнено успешно.

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу и перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/objects/delete-all.md) все объекты из бакета {{ objstorage-name }}, созданного при установке приложения.

1. Удалите приложение **Статический сайт в {{ objstorage-name }}** в {{ cloud-apps-name }}:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором установлено приложение.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. Найдите в списке приложение **Статический сайт в {{ objstorage-name }}**.
   1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) рядом с приложением и выберите **{{ ui-key.yacloud.common.delete }}**.
   1. Подтвердите удаление и дождитесь завершения. Пустой бакет и остальные ресурсы этого экземпляра приложения удаляются вместе с ним.

1. Если вы создавали сервисный аккаунт при установке приложения, [удалите](../../iam/operations/sa/delete.md) его.

1. [Удалите](../../dns/operations/zone-delete.md) публичную DNS-зону.

1. Удалите сервисное подключение {{ src-full-name }}:

   1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
   1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.lib.home_t2KmK }}** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.orgCommon.link_your-craftspace_bHYz8 }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.lib.repositories_vLJYc }}**.
   1. Выберите репозиторий, созданный из шаблона `cloudapp-gatsby`.
   1. В разделе ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.repo.title_navigation-repository-settings_35xCK }}** перейдите в секцию ![image](../../_assets/console-icons/cloud-nut-hex.svg) **{{ ui-key.sourcecraft.mainApp.route_service-connections_2PPgz }}** и выберите нужное сервисное подключение.
   1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

1. [Удалите]({{ link-src-docs }}/sourcecraft/operations/repo-delete) репозиторий, созданный из шаблона в {{ src-full-name }}.
