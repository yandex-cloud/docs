# Развертывание веб-приложения с JWT-авторизацией в {{ api-gw-name }} и аутентификацией в Firebase

В этом руководстве вы узнаете, как реализовать аутентификацию и авторизацию в вашем веб-приложении на основе протоколов [OAuth 2.0](https://oauth.net/2/) и [OpenID Connect](https://openid.net/connect/). Для аутентификации будут использованы [Google OAuth](https://developers.google.com/identity/protocols/oauth2) и [Firebase](https://firebase.google.com/docs). Авторизация будет выполняться на стороне {{ api-gw-name }} с помощью JWT-авторайзера. Веб-приложение будет состоять из:

* внешнего сервиса аутентификации Firebase;
* простого REST API, развернутого в виде {{ api-gw-name }};
* статического веб-сайта, развернутого в бакете {{ objstorage-name }}.

Чтобы развернуть веб-приложение:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте проект и настройте Google OAuth в Google Cloud](#create-google-cloud-project).
1. [Настройте аутентификацию в Firebase](#create-firebase-project).
1. [Завершите настройку ресурсов Google](#google-oauth-setup).
1. [Создайте API-шлюз](#create-gateway).
1. [Подготовьте файлы веб-приложения](#project-prepare).
1. [Разверните ресурсы {{ yandex-cloud }} и загрузите веб-приложение в бакет](#deploy).
1. [Проверьте работу созданного приложения](#test).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для работы веб-приложения входят:
* Плата за хранение данных в бакете и операции с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Плата за использование API-шлюза (см. [тарифы {{ api-gw-name }}](../../api-gateway/pricing.md)).


## Создайте проект и настройте Google OAuth в Google Cloud {#create-google-cloud-project}

Настройте Google OAuth:

1. Авторизуйтесь в [Google Cloud Console](https://console.cloud.google.com/) и создайте новый проект.
1. На вкладке **API & Services** → **OAuth consent screen** выберите тип приложения `External` и нажмите кнопку **Create**.
1. В разделе **OAuth consent screen** укажите название приложения и ваш адрес электронной почты в полях **User support email** и **Developer contact information**. Нажмите кнопку **Save and continue**.
1. В разделе **Scopes** нажмите кнопку **Add or Remove Scopes** и добавьте скоупы `openid`, `/auth/userinfo.email` и `/auth/userinfo.profile`. Нажмите **Update** → **Save and continue**.
1. В разделе **Test users** укажите ваш адрес электронной почты. Завершите создание приложения.
1. На вкладке **API & Services** → **Credentials** нажмите кнопку **Create credential** и выберите `OAuth client ID`. В качестве типа приложения укажите `Web application`.
1. Подтвердите создание приложения и сохраните `Client ID` и `Client secret`.

## Настройте аутентификацию в Firebase {#create-firebase-project}

1. Авторизуйтесь в [Firebase Console](https://console.firebase.google.com) и создайте новый проект.
1. В разделе **Authentication** → **Sign-in method** → **Custom providers** выберите `OpenID Connect`.
1. Подтвердите выбор `OpenID Connect`.
1. Укажите имя провайдера, `Client ID` и `Client secret`, которые получили на [предыдущем шаге](#create-google-cloud-project), а также заполните поле **Issuer** — для Google OAuth оно должно иметь значение `https://accounts.google.com`.
1. Сохраните `Callback URL` и завершите настройку OpenID.

## Завершите настройку ресурсов Google {#google-oauth-setup}

Google Console:

   1. На вкладке **API & Services** → **Credentials** нажмите на имя созданного клиента.
   1. В список **Authorized redirect URIs** добавьте Callback URL из Firebase, который получили на [предыдущем шаге](#create-firebase-project). Сохраните внесенные изменения.

Firebase:

   1. Перейдите в раздел **Project Overview** → **Project settings**.
   1. На вкладке `General` создайте веб-приложение. Укажите имя приложения и нажмите кнопку **Register App**.
   1. Сохраните сгенерированную в блоке `firebaseConfig` конфигурацию приложения.

## Создайте API-шлюз {#create-gateway}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо создать API-шлюз.
    1. В списке сервисов выберите **{{ api-gw-name }}**.
    1. Нажмите кнопку **Создать API-шлюз**.
    1. В поле **Имя** введите `jwt-api-gw`.
    1. В блок **Спецификация** добавьте спецификацию:

        ```yaml
        openapi: 3.0.0
        info:
          title: Sample API
          version: 1.0.0

        paths:
          /:
            get:
              x-yc-apigateway-integration:
                type: http
                url: https://oauth2.googleapis.com/tokeninfo
                method: GET
                query:
                  id_token: '{token}'
              parameters:
                - name: token
                  in: query
                  required: true
                  schema:
                    type: string
              security:
                - OpenIdAuthorizerScheme: [ ]
          
        components:
          securitySchemes:
            OpenIdAuthorizerScheme:
              type: openIdConnect
              x-yc-apigateway-authorizer:
                type: jwt
                jwksUri: https://www.googleapis.com/oauth2/v3/certs
                identitySource:
                  in: query
                  name: token
                issuers:
                  - https://accounts.google.com
                requiredClaims:
                  - email
        ```

    1. Нажмите кнопку **Создать**.

{% endlist %}

## Подготовьте файлы веб-приложения {#project-prepare}

1. Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-serverless-apigw-jwt-authorizer-firebase) с исходным кодом приложения:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-apigw-jwt-authorizer-firebase.git
   ```

1. Откройте с помощью текстового редактора файл `src/App.js` и укажите параметры:

   * `firebaseConfig` — конфигурация приложения Firebase, которую вы сохранили при [завершении настройки ресурсов Google](#google-oauth-setup).
   * `providerId` — идентификатор созданного ранее в Firebase провайдера OpenID Connect в формате `oidc.<имя_провайдера>`.
   * `apiGwDomain` — служебный домен созданного ранее API-шлюза.

1. [Установите Node.js](https://nodejs.org/ru/download/) и менеджер пакетов npm. Менеджер пакетов будет установлен автоматически при установке Node.js.
1. В папке с вашим приложением:

   1. Установите react-scripts в ваш проект и добавьте его в зависимости (devDependencies) в файле `package.json`:

      ```bash
      npm install react-scripts --save-dev
      ```

   1. Запустите сборку приложения:

      ```bash
      npm run build
      ```

      Результат выполнения команды:

      ```bash
      File sizes after gzip:

        96.05 kB  build\static\js\main.de7af71f.js
        672 B     build\static\css\main.021818e9.css

      The project was built assuming it is hosted at /.
      You can control this with the homepage field in your package.json.

      The build folder is ready to be deployed.
      ```

## Разверните ресурсы {{ yandex-cloud }} и загрузите веб-приложение в бакет {{ objstorage-name }} {#deploy}

Разверните статический веб-сайт:

1. Создайте бакет {{ objstorage-name }}:

   {% list tabs %}

   - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../../storage/concepts/bucket.md).
      1. Выберите сервис **{{ objstorage-name }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
      1. На странице создания бакета:
          1. Введите имя бакета — `bucket-for-tutorial`.
          1. В поле **Доступ на чтение объектов** выберите `Публичный`.
          1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.

   {% endlist %}

1. Загрузите объекты в бакет {{ objstorage-name }}:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который нужно загрузить объекты.
     1. Выберите сервис **{{ objstorage-name }}**.
     1. Нажмите на бакет `bucket-for-tutorial`.
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
     1. В появившемся окне выберите [сгенерированные ранее](#project-prepare) объекты в папке `build` и нажмите кнопку **Открыть**.
     1. Консоль управления отобразит все объекты, выбранные для загрузки, и предложит для каждого из них выбрать [класс хранилища](../../storage/concepts/storage-class.md). Класс хранилища по умолчанию определяется [настройкой бакета](../../storage/concepts/bucket.md#bucket-settings).
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.button_upload }}**.
     1. Обновите страницу.

     В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.

   {% endlist %}

1. Настройте хостинг статического сайта:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) перейдите в бакет `bucket-for-tutorial`.
     1. Перейдите на вкладку ![website](../../_assets/storage/website.svg) **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
     1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**:
         * в поле **{{ ui-key.yacloud.storage.bucket.website.field_index }}** укажите абсолютный путь к файлу главной страницы сайта — `index.html`.
         * в поле **{{ ui-key.yacloud.storage.bucket.website.field_error }}** укажите абсолютный путь к файлу, который будет отображаться при ошибках 4хх — `error.html`.
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
     1. В поле **Ссылка** скопируйте адрес вашего сайта.

   {% endlist %}

1. Добавьте адрес вашего сайта в список допустимых доменов в Firebase:

   1. Перейдите в раздел **Authentication** → **Settings** → **Authorized domains**.
   1. Нажмите кнопку **Add domain** и вставьте скопированный адрес.

## Протестируйте работу созданного приложения {#test}

1. Обратитесь к статическому сайту по адресу, который получили при [настройке хостинга](#deploy), и нажмите кнопку **Call {{ api-gw-short-name }}**, не проходя авторизации. Убедитесь, что в ответ приходит ошибка `Got error: Request failed with status code 401`.
1. Чтобы авторизоваться на сайте, нажмите кнопку **Log in**.
1. После авторизации снова нажмите кнопку **Call {{ api-gw-short-name }}**. Убедитесь, что вызов успешно обрабатывается и в ответ приходит информация об авторизованном пользователе.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).
1. [Удалите проект в Firebase](https://support.google.com/firebase/answer/9137886?hl=en).
1. [Удалите проект в Google Cloud](https://cloud.google.com/go/getting-started#clean-up).