# Настройка рабочего процесса Workflows с интеграцией с Яндекс Трекер, Yandex AI Studio и Yandex Cloud Postbox


{% note info %}

Workflows находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

В данном руководстве вы создадите [рабочие процессы](../../serverless-integrations/concepts/workflows/workflow.md) Yandex Workflows и настроите их интеграцию с [Яндекс Трекер](https://yandex.ru/support/tracker/ru/), [Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/generation/index) и [Yandex Cloud Postbox](../../postbox/index.md).

Созданные рабочие процессы будут получать информацию о задачах в указанной [очереди](https://yandex.ru/support/tracker/ru/about-tracker#ochered) Трекер, с помощью модели YandexGPT Pro анализировать проделанную в этих задачах работу, статусы задач и выставленные оценки. Результаты анализа и краткий отчет о проделанной работе будут сохраняться в комментарии к одной из задач в Трекер, а также дублироваться письмом на заданный адрес электронной почты с помощью сервиса Yandex Cloud Postbox.

Чтобы настроить рабочий процесс Workflows:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#service-account).
1. [Подготовьте Трекер](#prepare-tracker).
1. [Настройте доступ рабочего процесса в Трекер](#setup-tracker-access).
1. [Создайте адрес и пройдите проверку прав владения доменом в Yandex Cloud Postbox](#setup-postbox).
1. [Создайте рабочий процесс Workflows](#setup-workflow).
1. [Протестируйте рабочий процесс](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Войдите](https://passport.yandex.ru/auth) в ваш аккаунт на Яндексе. Если у вас еще нет аккаунта, [создайте](https://yandex.ru/support/passport/authorization/registration.html) его.
1. Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
    1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
    1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

    Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

    [Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md). 
1. Установите утилиту [cURL](https://curl.haxx.se), она понадобится для отправки запроса на получение OAuth-токена приложения Яндекс ID.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* плата за хранение [секрета](../../lockbox/concepts/secret.md) и запросы к нему (см. [тарифы Yandex Lockbox](../../lockbox/pricing.md));
* плата за использование Yandex AI Studio (см. [тарифы Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/pricing));
* плата за использование Яндекс Трекер (см. [тарифы Трекер](https://yandex.ru/support/tracker/ru/pricing));
* плата за использование Yandex Cloud Postbox (см. [тарифы Yandex Cloud Postbox](../../postbox/pricing.md)).

## Создайте сервисный аккаунт {#service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать рабочие процессы.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт** и в открывшемся окне:
      1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `workflow-sa`.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../iam/concepts/access-control/roles.md) `serverless.workflows.executor`.
      1. Повторите предыдущее действие, чтобы добавить роли [`postbox.sender`](../../postbox/security/index.md#postbox-sender) и [`ai.languageModels.user`](https://aistudio.yandex.ru/docs/ru/ai-studio/security/index#languageModels-user).
      1. Нажмите кнопку **Создать**.

{% endlist %}

## Подготовьте очередь и задачи в Трекер {#prepare-tracker}

Чтобы рабочие процессы, которые вы создадите в настоящем руководстве, работали корректно, настройте очередь в Яндекс Трекер.

{% list tabs group=instructions %}

- Интерфейс Трекер {#console}

  1. Если в вашей организации не подключен Яндекс Трекер, [подключите](https://yandex.ru/support/tracker/ru/enable-tracker) его.
  1. Если у вас в Трекер еще нет очереди, [создайте](https://yandex.ru/support/tracker/ru/manager/create-queue) ее.
  1. [Создайте](https://yandex.ru/support/tracker/ru/user/create-ticket) в вашей очереди 5–10 тестовых задач, отвечающих следующим требованиям:

      * Тестовые задачи должны быть созданы в одной очереди.
      * Для всех тестовых задач в поле **Теги** должен быть установлен [тег](https://yandex.ru/support/tracker/ru/glossary#rus-t) `product`.
      * Для всех тестовых задач в поле **Story Points** должна быть задана оценка в единицах [Story Point](https://yandex.ru/support/tracker/ru/glossary#en-s).
      * Часть тестовых задач должна быть в [статусе](https://yandex.ru/support/tracker/ru/about-tracker#process) `Закрыт`, часть — в статусе `Открыт`.
      * В закрытые тестовые задачи должны быть [добавлены](https://yandex.ru/support/tracker/ru/user/comments) комментарии о прогрессе работы над этими задачами.

{% endlist %}

## Настройте доступ для аутентификации рабочего процесса в Трекер {#setup-tracker-access}

Чтобы аутентифицировать рабочий процесс в Яндекс Трекер, получите токен [OAuth-приложения](https://yandex.ru/dev/id/doc/ru/concepts/ya-oauth-intro), у которого есть права на чтение и запись в Трекер.

### Создайте OAuth-приложение в Яндекс ID {#create-app}

Чтобы создать OAuth-приложение с правами доступа на чтение и запись в Трекер:

1. Перейдите в браузере на [страницу создания OAuth-приложения](https://oauth.yandex.ru/client/new/). На открывшейся странице:
    1. В поле **Название вашего сервиса** введите название создаваемого OAuth-приложения: `My Tracker Workflow`.
    1. В блоке **Платформы приложения** выберите опцию **Веб-сервисы** и в появившемся поле задайте Redirect URI: `https://oauth.yandex.ru/verification_code`.
    1. В блоке **Доступ к данным** в поле **Название доступа** введите `tracker:read` и выберите доступ `Чтение из трекера`. 

        Доступ `Чтение из трекера` появится ниже в списке доступов приложения.

        Аналогичным образом добавьте доступ `tracker:write` (`Запись в трекер`).
    1. В блоке **Почта для связи** укажите ваш адрес электронной почты для отправки уведомлений по создаваемому приложению.
    1. Нажмите кнопку **Создать приложение**.

На открывшейся странице созданного приложения скопируйте значения полей **ClientID** и **Client secret**. Они понадобятся на следующем этапе для получения OAuth-токена.

### Получите OAuth-токен приложения {#create-token}

1. [Получите](https://yandex.ru/dev/id/doc/ru/codes/code-url#code) код подтверждения. Для этого вставьте в адресную строку браузера следующий адрес, указав в query-параметре `client_id` скопированное на предыдущем шаге значение:

    ```text
    https://oauth.yandex.ru/authorize?response_type=code&client_id=<значение_ClientID>
    ```

    Подтвердите, что предоставляете доступ вашему OAuth-приложению к Трекер.

    В открывшемся окне скопируйте и сохраните полученный код подтверждения. Он понадобится для получения OAuth-токена.
1. Получите OAuth-токен приложения. Для этого в терминале выполните команду:

    ```bash
    curl \
      --request POST \
      --header "Content-type: application/x-www-form-urlencoded" \
      --data "grant_type=authorization_code&code=<код_подтверждения>&client_id=<значение_ClientID>&client_secret=<значение_Client_secret>" \
      https://oauth.yandex.ru/token
    ```

    Где:
    * `code` — полученный на предыдущем шаге код подтверждения.
    * `client_id` — полученное ранее значение **ClientID** вашего OAuth-приложения.
    * `client_secret` — полученное ранее значение **Client secret** вашего OAuth-приложения.

    Результат:

    ```json
    {"access_token": "y0__wgBhMmiugUY4b40IJCda4YSeAfV5tAoPqy2tttkQsy********", "expires_in": 31536000, "refresh_token": "1:7WGrfpErRSTlkTJI:NGU-BJxhvhUdwDxDuez5ana4Befm63bXXhNpJFnbWDX1XJ_rJ3qh6DH_AItBhFJk********:ZZP-Pf0nxo4nil********", "token_type": "bearer"}%
    ```

    Сохраните полученное значение поля `access_token` — это OAuth-токен приложения, необходимый для доступа рабочего процесса к Трекер.

### Создайте секрет Yandex Lockbox {#create-secret}

Создайте [секрет](../../lockbox/quickstart.md) Yandex Lockbox для хранения OAuth-токена и назначьте сервисному аккаунту права доступа к созданному секрету.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором ранее создали сервисный аккаунт.
  1. Перейдите в сервис **Lockbox**.
  1. Нажмите кнопку **Создать секрет** и в открывшемся окне:

      1. В поле **Имя** введите имя секрета: `tracker-oauth-token`.
      1. В поле **Тип секрета** выберите `Пользовательский`.
      1. В поле **Ключ** введите ключ секрета: `oauth`.
      1. В поле **Значение** укажите OAuth-токен приложения, полученный на предыдущем шаге.
      1. Нажмите кнопку **Создать**.
  1. Нажмите на строку с созданным секретом `tracker-oauth-token` и в открывшемся окне:

      1. Скопируйте и сохраните значение поля **Идентификатор**. Оно понадобится позднее при создании спецификации рабочего процесса.
      1. Перейдите на вкладку ![persons](../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
      1. В поисковой строке введите имя созданного ранее сервисного аккаунта `workflow-sa` и выберите найденный сервисный аккаунт.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.
      1. Нажмите **Сохранить**.

{% endlist %}

## Создайте адрес и пройдите проверку прав владения доменом в Yandex Cloud Postbox {#setup-postbox}

Чтобы рабочий процесс мог отправлять письма, создайте [адрес](../../postbox/concepts/glossary.md#adress) Yandex Cloud Postbox и подтвердите владение доменом, с которого будут отправляться письма.

### Создайте адрес Yandex Cloud Postbox {#create-address}

1. Сгенерируйте ключ для создания DKIM-подписи. Для этого в терминале выполните команду:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

    Созданный ключ будет сохранен в файле `privatekey.pem` в текущей директории.

1. Создайте адрес:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы ранее создали сервисный аккаунт и секрет.
        1. Перейдите в сервис **Cloud Postbox**.
        1. Нажмите кнопку **Создать адрес**.
        1. В поле **Домен** укажите домен, с которого будете отправлять письма. Например: `example.com`.

            Домен может быть любого уровня. У вас должны быть права на добавление [ресурсных записей](../../dns/concepts/resource-record.md) в публичную [зону DNS](../../dns/concepts/dns-zone.md) указанного домена — это необходимо для подтверждения ваших прав на его использование.
        1. В поле **Селектор** укажите селектор. Например: `tracker_workflow`. 

            Имя указанного селектора будет использовано для создания ресурсной записи TXT, поэтому каждый создаваемый селектор должен быть уникальным в пределах вашего домена.
        1. В поле **Приватный ключ** скопируйте содержимое созданного ранее файла приватного ключа `privatekey.pem`.
        1. Нажмите кнопку **Создать адрес**.
        1. В появившемся списке адресов выберите созданный адрес и на открывшейся странице в блоке **Подтверждение подписи** скопируйте и сохраните значения полей **Имя** и **Значение** — они понадобятся для создания ресурсной записи TXT.

    {% endlist %}

### Пройдите проверку прав владения доменом {#validate-domain}

1. В публичной зоне DNS вашего домена создайте [ресурсную запись TXT](../../dns/concepts/resource-record.md#txt) со следующими значениями:

    * **Имя записи**: скопированное на предыдущем шаге значение поля **Имя**.

        В Yandex Cloud DNS укажите часть имени, сгенерированного при создании адреса, без указания домена, в формате `<селектор>._domainkey`, например `tracker_workflow._domainkey`.

        Для других DNS-сервисов может потребоваться скопировать запись целиком. Итоговая запись должна иметь вид `<селектор>._domainkey.<домен>.`, например `tracker_workflow._domainkey.example.com.`.

    * **Тип записи**: `TXT`.
    * **Значение записи**: скопированное на предыдущем шаге значение поля **Значение**.
    
        Обратите внимание, что значение записи нужно взять в кавычки, например:

        ```text
        "v=DKIM1;h=sha256;k=rsa;p=M1B...aCA8"
        ```

    {% note info %}
    
    Если ваш домен делегирован Yandex Cloud DNS, создайте ресурсную запись по [инструкции](../../dns/operations/resource-record-create.md). В остальных случаях воспользуйтесь личным кабинетом вашего регистратора доменных имен. Если нужна помощь, обратитесь к документации регистратора или в его поддержку.
    
    {% endnote %}

1. Выполните проверку прав на домен.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится созданный адрес.
        1. Перейдите в сервис **Cloud Postbox** и выберите нужный адрес.
        1. Нажмите кнопку **Запустить проверку**. Если TXT-запись создана корректно, статус проверки на странице адреса изменится на `Success`.

            Ответы DNS-сервера кешируются, поэтому возможны задержки при обновлении ресурсной записи.

    {% endlist %}

## Создайте рабочий процесс Workflows {#setup-workflow}

1. Выберите спецификацию, которую вы будете использовать для создания рабочего процесса. Обе приведенные спецификации используют интеграции с Яндекс Трекер, Yandex AI Studio и Yandex Cloud Postbox, но по-разному анализируют исходные данные.

    {% list tabs %}

    - Вариант 1

      {% note tip %}
      
      В этом руководстве описано создание рабочего процесса с помощью YaWL-спецификации, но его также можно создать и редактировать с помощью [конструктора](../../serverless-integrations/operations/workflows/constructor/index.md).
      
      {% endnote %}

      ![tracker-yandexgpt-postbox-integrations-first-workflow](../../_assets/tutorials/tracker-yandexgpt-postbox-integrations-first-workflow.png)

      Предлагаемый рабочий процесс анализирует задачи Трекер в указанной очереди, формирует и публикует отчет о прогрессе работы в этих задачах:

      1. Анализ задач с нужным тегом в заданной очереди Трекер:
          * общее количество задач;
          * общая суммарная оценка задач в единицах [Story Point](https://yandex.ru/support/tracker/ru/glossary#en-s);
          * количество закрытых задач;
          * процентное соотношение количества закрытых задач к общему количеству задач;
          * суммарная оценка закрытых задач в единицах `Story Point`;
          * процентное соотношение суммарной оценки закрытых задач к общей суммарной оценке всех задач в единицах `Story Point`.
      1. Формирование отчета с результатами анализа.
      1. Публикация отчета в комментарии к заданной задаче Трекер, а также отправка отчета на заданный адрес электронной почты.

      **Код спецификации:**

      ```yaml
      yawl: "0.1"
      start: fetch_tickets
      steps:
        fetch_tickets:
          tracker:
            organization:
              cloudOrganizationId: <идентификатор_организации>
            oauthToken: '\(lockboxPayload("<идентификатор_секрета>"; "oauth"))'
            listIssues:
              filter:
                issueProperties:
                  queue: <ключ_очереди_в_Трекер>
                  tags: "product"
            output: |-
              \({
                "sp_sum": [.[].storyPoints] | add,
                "closed_sp_sum": . | map(select(.status.key == "closed")) | map(.storyPoints) | add,
                "ticket_count": . | length,
                "closed_ticket_count": . | map(select(.status.key == "closed")) | length,
                "non_closed_ticket_texts": . | map(select(.status.key != "closed")) | map({
                  "key": .key,
                  "summary": .summary,
                  "description": .description            
                })
              })
            next: summarize_texts
        summarize_texts:
          foundationModelsCall:
            next: create_report
            modelUrl: gpt://<идентификатор_каталога>/yandexgpt
            generate:
              maxTokens: 500
              temperature: 0.5
              messages:
                messages:
                  - role: system
                    text: "Далее будут даны названия незавершенных задач в Трекер и их описание. Сформулируй как можно короче (не больше трех предложений), что осталось сделать"
                  - role: user
                    text: |-
                      \("
                        \(.non_closed_ticket_texts | map(.summary + ": " + .description) | join(". "))
                      ")
            output: |-
              \({
                "summary": .alternatives.[0].message.text
              })
        create_report:
          noOp:
            output: |-
              \({
              "report_text": "**Количество работы всего:** \(.ticket_count) задач(а), \(.sp_sum) sp
              **Работы завершено:** \(.closed_ticket_count) (\(100 * .closed_ticket_count / .ticket_count | round)%) задач(а), \(.closed_sp_sum) (\(100 * .closed_sp_sum / .sp_sum | round)%) sp

              **Незавершенные задачи:**
                \(.non_closed_ticket_texts | map(.key) | join("\n"))

              **Сводка по тому, что осталось:**
                \(.summary)
              ",
              "report_text_html": "<b>Количество работы всего:</b> \(.ticket_count) задач(а), \(.sp_sum) sp<br>
              <b>Работы завершено:</b> \(.closed_ticket_count) (\(100 * .closed_ticket_count / .ticket_count | round)%) задач(а), \(.closed_sp_sum) (\(100 * .closed_sp_sum / .sp_sum | round)%) sp<br>
              <br>
              <b>Незавершенные задачи:</b><br>
                \(.non_closed_ticket_texts | map("<a href=https://tracker.yandex.ru/" + .key + ">" + .key + "</a>") | join("<br>"))<br>
              <br>
              <b>Сводка по тому, что осталось:</b><br>
                \(.summary | gsub("\\n"; "<br>"))
              "})
            next: deliver_report
        deliver_report:
          parallel:
            branches:
              tracker:
                start: write_report_to_tracker
                steps:
                  write_report_to_tracker:
                    tracker:
                      organization:
                        cloudOrganizationId: <идентификатор_организации>
                      oauthToken: '\(lockboxPayload("<идентификатор_секрета>"; "oauth"))'
                      createComment:
                        key: <ключ_задачи_с_отчетом>
                        text: \(.report_text)
              postbox:
                start: send_report_via_postbox
                steps:
                  send_report_via_postbox:
                    postbox:
                      simple:
                        subject:
                          data: "Dev progress report"
                          charset: UTF_8
                        body:
                          text:
                            data: \(.report_text)
                            charset: UTF_8
                          html:
                            data: \("<p>\(.report_text_html)</p>")
                            charset: UTF_8
                      fromAddress: tracker-robot@<ваш_домен>
                      destination:
                        toAddresses: <адрес_получателя>
      ```

      Где:

      * `<идентификатор_организации>` — [идентификатор](../../organization/operations/organization-get-id.md) вашей организации Yandex Identity Hub.
      * `<идентификатор_секрета>` — сохраненный ранее идентификатор [секрета](../../lockbox/concepts/secret.md) с OAuth-токеном приложения.
      * `<ключ_очереди_в_Трекер>` — [ключ](https://yandex.ru/support/tracker/ru/glossary#rus-k) очереди Трекер, в которой вы создали тестовые задачи.
      * `<идентификатор_каталога>` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором вы создаете рабочий процесс.
      * `<ключ_задачи_с_отчетом>` — ключ [задачи](https://yandex.ru/support/tracker/ru/glossary#rus-z) Трекер, в комментарий к которой будет выгружена сводка по проанализированным тестовым задачам.
      * `<ваш_домен>` — домен, который вы указали при создании адреса Yandex Cloud Postbox. В качестве адреса отправителя `fromAddress` вы можете указать любой адрес на этом домене. Например: `tracker-robot@example.com` или `noreply@example.com`.
      * `<адрес_получателя>` — адрес электронной почты, на который рабочий процесс отправит письмо со сводкой по проанализированным тестовым задачам Трекер.

      Рабочий процесс включает в себя следующие шаги: `fetch_tickets`, `summarize_texts`, `send_report_via_postbox` и `write_report_to_tracker`.

    - Вариант 2

      {% note tip %}
      
      В этом руководстве описано создание рабочего процесса с помощью YaWL-спецификации, но его также можно создать и редактировать с помощью [конструктора](../../serverless-integrations/operations/workflows/constructor/index.md).
      
      {% endnote %}

      ![tracker-yandexgpt-postbox-integrations-second-workflow](../../_assets/tutorials/tracker-yandexgpt-postbox-integrations-second-workflow.png)

      Предлагаемый рабочий процесс анализирует закрытые задачи Трекер за последнюю неделю, формирует и публикует отчет о проделанной в этих задачах работе:
      1. Анализ задач, закрытых за последнюю неделю:
          * выгрузка комментариев к задачам;
          * анализ и обобщение комментариев к каждой закрытой задаче.
      1. Формирование отчета с обобщением выполненной работы в каждой закрытой задаче.
      1. Публикация отчета в комментарии к заданной задаче Трекер, а также отправка отчета на заданный адрес электронной почты.

      **Код спецификации:**

      ```yaml
      yawl: "0.1"
      start: fetch_tickets
      steps:
        fetch_tickets:
          tracker:
            organization:
              cloudOrganizationId: <идентификатор_организации>
            oauthToken: '\(lockboxPayload("<идентификатор_секрета>"; "oauth"))'
            listIssues:
              query: 'Status: changed(to: Closed date: >now()-2w)'
            output: |-
              \({
                "closed_tickets": . | map({"ticket_key": .key})
              })
            next: fetch_comments_fe
        fetch_comments_fe:
          foreach:
            input: \(.closed_tickets)
            do:
              start: fetch_comments
              steps:
                fetch_comments:
                  tracker:
                    organization:
                      cloudOrganizationId: <идентификатор_организации>
                    oauthToken: '\(lockboxPayload("<идентификатор_секрета>"; "oauth"))'
                    listComments:
                      key: \(.ticket_key)
                    output: |-
                      \({
                        "comments": .
                      })
            output: |-
              \({
                "comment_text": map(.comments[].text) | join("\n")
              })
            next: summarize_texts
        summarize_texts:
          foundationModelsCall:
            modelUrl: gpt://<идентификатор_каталога>/yandexgpt
            generate:
              maxTokens: 500
              temperature: 0.5
              messages:
                messages:
                  - role: system
                    text: "Далее будут даны комментарии завершенных задач в Трекер. Сформулируй как можно короче (не больше трех предложений), какая работа была проделана."
                  - role: user
                    text: \(.comment_text)
            output: |-
              \({
                "summary": .alternatives.[0].message.text
              })
            next: create_report
        create_report:
          noOp:
            output: |-
              \({
                "report_text": "
                  Завершенные задачи:
                    \(.closed_tickets | map(.ticket_key) | join("\n"))
                  Сводка по закрытым задачам:
                    \(.summary)
                ",
                "report_text_html": "
                  Завершенные задачи:<br>
                    \(.closed_tickets | map("<a href=https://tracker.yandex.ru/" + .ticket_key + ">" + .ticket_key + "</a>") | join("<br>"))<br>

                  <br>
                  Сводка по закрытым задачам:<br>
                    \(.summary | gsub("\\n"; "<br>")))
                "
              })
            next: deliver_report
        deliver_report:
          parallel:
            branches:
              tracker:
                start: write_report_to_tracker
                steps:
                  write_report_to_tracker:
                    tracker:
                      organization:
                        cloudOrganizationId: <идентификатор_организации>
                      oauthToken: '\(lockboxPayload("<идентификатор_секрета>"; "oauth"))'
                      createComment:
                        key: <ключ_задачи_с_отчетом>
                        text: \(.report_text)
              postbox:
                start: send_report_via_postbox
                steps:
                  send_report_via_postbox:
                    postbox:
                      simple:
                        subject:
                          data: "Dev progress report (closed issues)"
                          charset: UTF_8
                        body:
                          text:
                            data: \(.report_text)
                            charset: UTF_8
                          html:
                            data: \("<p>\(.report_text_html)</p>")
                            charset: UTF_8
                      fromAddress: tracker-robot@<ваш_домен>
                      destination:
                        toAddresses: <адрес_получателя>
        ```

      Где:

      * `<идентификатор_организации>` — [идентификатор](../../organization/operations/organization-get-id.md) вашей организации Yandex Identity Hub.
      * `<идентификатор_секрета>` — сохраненный ранее идентификатор [секрета](../../lockbox/concepts/secret.md) с OAuth-токеном приложения.
      * `<идентификатор_каталога>` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором вы создаете рабочий процесс.
      * `<ключ_задачи_с_отчетом>` — ключ [задачи](https://yandex.ru/support/tracker/ru/glossary#rus-z) Трекер, в комментарий к которой будет выгружена сводка по проанализированным тестовым задачам.
      * `<ваш_домен>` — домен, который вы указали при создании адреса Yandex Cloud Postbox. В качестве адреса отправителя `fromAddress` вы можете указать любой адрес на этом домене. Например: `tracker-robot@example.com` или `noreply@example.com`.
      * `<адрес_получателя>` — адрес электронной почты, на который рабочий процесс направит письмо со сводкой по проанализированным тестовым задачам Трекер.

      Рабочий процесс включает в себя следующие шаги: `fetch_tickets`, `fetch_comments`, `summarize_texts`, `send_report_via_postbox` и `write_report_to_tracker`.

    {% endlist %}

1. Создайте рабочий процесс Workflows с использованием выбранной спецификации:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находятся созданные ранее ресурсы — сервисный аккаунт, секрет и адрес Yandex Cloud Postbox.
        1. Перейдите в сервис **Serverless Integrations**.
        1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **Workflows**.
        1. В правом верхнем углу нажмите кнопку **Создать рабочий процесс** и в открывшемся окне:

            1. В поле **YaML-спецификация** добавьте выбранную ранее спецификацию.
            1. Разверните блок **Дополнительные параметры**.
            1. В поле **Имя** введите имя рабочего процесса: `my-tracker-workflow`.
            1. В поле **Сервисный аккаунт** выберите созданный ранее сервисный аккаунт `workflow-sa`.
        1. Нажмите кнопку **Создать**.

    {% endlist %}

## Протестируйте рабочий процесс {#test}

Убедитесь, что процесс Workflows выполняется.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится созданный рабочий процесс Workflows.
    1. Перейдите в сервис **Serverless Integrations**.
    1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **Workflows**.
    1. В строке с рабочим процессом `my-tracker-workflow` нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![TriangleRight](../../_assets/console-icons/triangle-right.svg) **Запустить**.
    1. В открывшемся окне нажмите **Запустить**. Будет запущен созданный ранее рабочий процесс, его выполнение может занять несколько минут.
    1. Перейдите на вкладку ![Timeline](../../_assets/console-icons/timeline.svg) **Шкала времени**.

        Убедитесь, что все этапы рабочего процесса завершены успешно. При успешном выполнении этапа в соответствующей строке шкалы времени будет отображаться блок зеленого цвета со значком ![CircleCheck](../../_assets/console-icons/circle-check.svg).

        При возникновении на каком-то из этапов ошибки, в соответствующей строке шкалы времени будет отображаться блок красного цвета со значком ![TriangleExclamation](../../_assets/console-icons/triangle-exclamation.svg). Нажав на этот блок, можно посмотреть подробности о возникшей ошибке.

{% endlist %}

В результате выполнения рабочего процесса в заданную в спецификации задачу Трекер будет добавлен комментарий со сводкой по проанализированным тестовым задачам. Эта сводка будет также продублирована письмом на заданный в спецификации адрес электронной почты.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. Удалите рабочий процесс:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находятся созданные ресурсы.
        1. Перейдите в сервис **Serverless Integrations**.
        1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **Workflows**.
        1. В строке с рабочим процессом `my-tracker-workflow` нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![TrashBin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
        1. Подтвердите удаление.

    {% endlist %}
1. [Удалите секрет](../../lockbox/operations/secret-delete.md).
1. Удалите [задачи](https://yandex.ru/support/tracker/ru/user/ticket-cancel) и [очередь](https://yandex.ru/support/tracker/ru/manager/delete-queue) Трекер.
1. При необходимости удалите адрес Yandex Cloud Postbox:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится созданный адрес Yandex Cloud Postbox.
        1. Перейдите в сервис **Cloud Postbox**.
        1. В строке с нужным адресом Yandex Cloud Postbox нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![TrashBin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
        1. Подтвердите удаление.

    {% endlist %}