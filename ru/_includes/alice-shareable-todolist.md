# Разработка навыка Алисы и сайта с авторизацией

В этом сценарии вы разработаете навык Алисы и развернете веб-приложение, которое позволит создавать, читать и редактировать списки дел с помощью Алисы, а также делиться списками с другими пользователями на сайте.

<iframe width="794" height="447" src="https://www.youtube.com/embed/PMWMDTBKFAc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Чтобы развернуть проект:
1. [Подготовьте окружение](#prepare)
2. [Создайте ресурсы](#create-resources)
3. [Задайте переменные проекта](#set-variables)
4. [Разверните проект](#deploy)
5. [Зарегистрируйте навык Алисы](#register-skill)
6. [Проверьте работу навыка](#test-skill)

## Подготовьте окружение {#prepare}

1. [Загрузите архив](https://storage.yandexcloud.net/doc-files/alice-shareable-todolist.zip) с файлами проекта или клонируйте [репозиторий examples](https://github.com/yandex-cloud/examples/tree/master/serverless/alice-shareable-todolist) с помощью Git.

1. [Создайте каталог](../resource-manager/operations/folder/create.md), если его еще нет. Для удобства можно использовать отдельный каталог с именем `alice-skill`.

1. Установите и инициализируйте следующие программы:
	* [Yandex Cloud CLI](../cli/quickstart.md);
	* [Yandex Database CLI](../ydb/quickstart/yql-api/ydb-cli.md);
	* [Командный интерпретатор Bash](http://www.gnu.org/software/bash/);
	* [AWS CLI](../storage/tools/aws-cli);
	* [jq](https://stedolan.github.io/jq/download/);
	* [Node.js](https://nodejs.org/en/download/package-manager/);
	* [Terraform](../solutions/infrastructure-management/terraform-quickstart).

1. Для доработки проекта дополнительно потребуются:
	* [Язык программирования Go](https://golang.org/).
	* Утилита [go-swagger](https://goswagger.io/).
	* Утилита [api-spec-converter](https://www.npmjs.com/package/api-spec-converter).

## Создайте ресурсы {#create-resources}

1. [Создайте бакет](https://cloud.yandex.ru/docs/storage/operations/buckets/create) в {{ objstorage-name }} с именем `frontend-statics`.
2. [Создайте API-шлюз](https://cloud.yandex.ru/docs/api-gateway/operations/api-gw-create) с именем `gate-1`. Для использования в конфигурации сохраните поля **Идентификатор** и **Служебный домен** из раздела **Общая информация**.
3. [Создайте базу данных](https://cloud.yandex.ru/docs/ydb/quickstart/create-db#control-plane) в режиме Serverless. Для использовании в конфигурации сохраните поля **База данных** и **Эндпойнт** из раздела **YDB эндпойнт**.
4. [Создайте приложение](https://oauth.yandex.ru/) в Яндекс.OAuth:
	1. Перейдите на [сайт сервиса](https://oauth.yandex.ru/) и авторизуйтесь.
	1. Нажмите кнопку **Зарегистрировать новое приложение**:
	1. Выберите подходящее имя приложения и загрузите иконку.
	1. В разделе **Платформы** отметьте пункт **Веб-сервисы**. Укажите два Callback URI:
		* `https://social.yandex.net/broker/redirect`;
		* `https://<служебный домен API-шлюза>/receive-token`.
		
		Обратите внимание, что указанный URL `receive-token` может быть недоступен до момента загрузки актуальной спецификации в API-шлюз. Спецификация будет загружена во время развертывания проекта.

	1. В разделе **Доступы** разверните **API Яндекс ID (login)** и отметьте пункт **Доступ к портрету пользователя (login:avatar)**.

	Подробнее о возможностях сервиса Яндекс.OAuth читайте в [документации](https://yandex.ru/dev/oauth/doc/dg/tasks/register-client.html).


## Задайте переменные проекта {#set-variables}

Сконфигурируйте проект с помощью значений, которые получили при создании ресурсов.

### Создайте файл variables.json

Файл `variables.json` содержит конфигурацию для развертывания проекта. Чтобы создать файл из шаблона `variables-template.json`, перейдите в каталог проекта и выполните команду:
```
cp variables-template.json variables.json
```
Задайте параметры проекта в файле `variables.json`:
*  `folder-id` — идентификатор каталога в облаке.
*  `domain` — служебный домен API-шлюза.
*  `oauth-client-id` — идентификатор приложения, зарегистрированного в [Яндекс.OAuth](https://oauth.yandex.ru/).
*  `database` — база данных из конфигурации Yandex Database.
*  `database-endpoint` — эндпойнт из конфигурации Yandex Database.
*  `yc-profile` — [название профиля](../cli/operations/profile/profile-list.md) Yandex Cloud CLI.
*  `secure-config-path` — путь к файлу секретов.
*  `storage-bucket` — имя созданного бакета для хранения статических данных, `frontend-statics`.
*  `gateway-id` — идентификатор API-шлюза.

### Создайте файл secure-config.json

Файл `secure-config.json` содержит секреты. Вы можете создать файл из шаблона `secure-config-template.json`. Для этого выполните команду:
```
cp secure-config-template.json secure-config.json
```
Подставьте значения переменных:

* `oauth_secret` — пароль приложения, зарегистрированного в [Яндекс.OAuth](https://oauth.yandex.ru/).
* `hash` — случайная строка длиной 64 байта, закодированная с помощью base64, например `qrJagO5NVwOj0FeTmgYSwUN+XXkiQJMWifvrklF53wT55q80Xk8vmEB3kxhtpDnA1WDC893Z9Bh6QcqKLbAUWQ==`.
* `block` — случайная строка длиной 32 байта, закодированная с помощью base64, например `uwk0duFgn2nYyfu2VzJe+MnWKWQrfKaiZijIzGZ8fqQ=`.

Сгенерировать случайные значения можно с помощью сайта [generate.plus](https://generate.plus/en/base64).

Убедитесь, что в файле `variables.json` указан правильный путь к `secure-config.json`.


## Разверните проект {#deploy}

Перенесите файлы проекта в {{ yandex-cloud }} и обновите конфигурацию.

### Примените схему данных

Чтобы создать таблицы в базе данных, выполните команду:

```
./upload_ydb_schema.sh
```

### Загрузите код бэкенда в {{ sf-name }}

Используйте Terraform для автоматизации действий. Перед использованием [проинициализируйте его](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart#configure-provider).

Для этого в папке с конфигурационным файлом app.tf выполните команду:
```
terraform init
```

После успешной инициализации выполните команду, передав значение [OAuth-токена](https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token) для авторизации в Yandex.Cloud:
```
terraform apply -var-file ./variables.json -var yc-token=<OAuth token>
```

Terraform автоматически создаст или обновит требуемые ресурсы.

### Загрузите код фронтенда в {{ objstorage-name }}

Чтобы развернуть веб-приложение фронтенда, скомпилируйте статические файлы и загрузите их в {{ objstorage-name }}.

1. Перед компиляцией статических файлов убедитесь, что установлен Node.js и пакетный менеджер npm.

1. Перейдите в подкаталог `frontend` и выполните компиляцию:
	```
	npm run build
	```
	Результат выполнения:
	
	```
	$ npm run build
	
	> todolist@0.1.0 build
	> react-scripts build
	
	Creating an optimized production build...
	Compiled successfully.
	
	File sizes after gzip:
	
	  75.93 KB  build/static/js/2.84be0fca.chunk.js
	  23.26 KB  build/static/css/2.ef9168ec.chunk.css
	  2.63 KB   build/static/js/main.d9e069c9.chunk.js
	  776 B     build/static/js/runtime-main.676997b0.js
	  402 B     build/static/css/main.e5cbab88.chunk.css
	
	The project was built assuming it is hosted at /.
	You can control this with the homepage field in your package.json.
	
	The build folder is ready to be deployed.
	You may serve it with a static server:
	
	  npm install -g serve
	  serve -s build
	```

1. Чтобы загрузить файлы в {{ objstorage-name }}, выполните команду:
	```
	./upload_static.sh
	```
	Результат выполнения:
	
	```
	$ ./upload_static.sh
	upload: frontend/build/robots.txt to s3://frontent-statics/robots.txt
	upload: frontend/build/manifest.json to s3://frontent-statics/manifest.json
	upload: frontend/build/static/css/main.e5cbab88.chunk.css.map to s3://frontent-statics/static/css/main.e5cbab88.chunk.css.map
	upload: frontend/build/index.html to s3://frontent-statics/index.html
	upload: frontend/build/asset-manifest.json to s3://frontent-statics/asset-manifest.json
	upload: frontend/build/static/js/2.84be0fca.chunk.js.LICENSE.txt to s3://frontent-statics/static/js/2.84be0fca.chunk.js.LICENSE.txt
	upload: frontend/build/static/css/main.e5cbab88.chunk.css to s3://frontent-statics/static/css/main.e5cbab88.chunk.css
	upload: frontend/build/static/js/main.d9e069c9.chunk.js to s3://frontent-statics/static/js/main.d9e069c9.chunk.js
	upload: frontend/build/static/js/2.84be0fca.chunk.js to s3://frontent-statics/static/js/2.84be0fca.chunk.js
	upload: frontend/build/static/js/runtime-main.676997b0.js to s3://frontent-statics/static/js/runtime-main.676997b0.js
	upload: frontend/build/static/js/runtime-main.676997b0.js.map to s3://frontent-statics/static/js/runtime-main.676997b0.js.map
	upload: frontend/build/static/js/main.d9e069c9.chunk.js.map to s3://frontent-statics/static/js/main.d9e069c9.chunk.js.map
	upload: frontend/build/static/css/2.ef9168ec.chunk.css to s3://frontent-statics/static/css/2.ef9168ec.chunk.css
	upload: frontend/build/static/css/2.ef9168ec.chunk.css.map to s3://frontent-statics/static/css/2.ef9168ec.chunk.css.map
	upload: frontend/build/static/js/2.84be0fca.chunk.js.map to s3://frontent-statics/static/js/2.84be0fca.chunk.js.map
	```

### Обновите конфигурацию API-шлюза

Чтобы загрузить актуальную спецификацию в {{ api-gw-name }}, выполните команду:

```
./update_gateway.sh
```
Результат выполнения:

```
done (2s)
id: d5dc6k34opmskp7ela3d
folder_id: b1guj13dic1461knkpbw
created_at: "2021-06-03T11:18:00.379Z"
name: gate-1
status: ACTIVE
domain: d5dc6k87opmskp7elb3q.apigw.yandexcloud.net
log_group_id: ckg57bweoekkrkddsknd
```

## Зарегистрируйте навык Алисы {#register-skill}

### Создайте диалог {#create-dialog}

1. Перейдите на сайт [Яндекс.Диалоги](https://dialogs.yandex.ru/) и авторизуйтесь в консоли.
1. Нажмите кнопку **Создать диалог** и выберите тип диалога — **Навык в Алисе**.
1. В поле **Имя навыка** задайте **Списки дел**.
1. В пункте **Backend** отметьте опцию **Функция в Яндекс.Облаке** и выберите из списка функцию `todo-list-alice`, которую вы ранее создали в сервисе Cloud Functions.
1. Включите опцию **Использовать хранилище данных в навыке**.

Остальные параметры задайте по своим предпочтениям. Например, вы можете задать разные словоформы для активации навыка, выбрать голос или тип доступа к навыку. 
Подробнее в [документации](https://yandex.ru/dev/dialogs/alice/doc/publish.html) сервиса Яндекс.Диалоги.

### Настройте авторизацию в Алисе

1. На вкладке **Главные настройки** найдите раздел **Связка аккаунтов**.
1. В строке **Авторизация** нажмите кнопку **Создать**.
1. Введите:
	* **Идентификатор** и **Секрет приложения** — ID и пароль, которые вы получили при регистрации приложения на сайте [Яндекс.OAuth](https://oauth.yandex.ru/).
	* **URL авторизации** — `https://oauth.yandex.ru/authorize`.
	* **URL для получения токена** — `https://oauth.yandex.ru/token`.
	* **URL для обновления токена** — `https://oauth.yandex.ru/token`.

Подробнее о протоколе OAuth 2.0 читайте в [RFC 6749](https://datatracker.ietf.org/doc/html/rfc6749).

### Добавьте интенты

1. Перейдите на вкладку **Интенты** и нажмите кнопку **Создать**.
1. Добавьте интенты для каждого действия, возможного в диалоге. Разработанные интенты находятся в подкаталоге `intents` проекта.
1. Введите:
	* **Название** — Произвольное имя, которое будет отображаться в интерфейсе.
	* **ID** — Идентификатор интента, равный имени файла в каталоге `intents`.
	* **Грамматика** — Текст грамматики, равный содержимому файла в каталоге `intents`.

Подробнее об интентах в [документации Навыков Алисы](https://yandex.ru/dev/dialogs/alice/doc/nlu-docpage/).

Чтобы завершить создание диалога, в правой части страницы нажмите кнопку **Опубликовать**.

## Проверьте работу навыка {#test-skill}

Для отладки навыка используйте вкладку **Тестирование** в консоли [Яндекс.Диалогов](https://dialogs.yandex.ru/developer) или одну из [поверхностей](https://yandex.ru/dev/dialogs/alice/doc/surfaces.html), выбранных при проектировании навыка.

### В консоли {#console-test}

Перейдите на вкладку **Тестирование**. В левой части отображается чат с Алисой, в правой — протокол взаимодействия в формате JSON.

Ниже приведен пример диалога:

```
Давайте я помогу вам со списками!

	Алиса, привет. Создай список Продукты

Готово, создала список "продукты"

	Добавь молоко в Продукты

Готово, добавила "молоко" в "продукты"

	Добавь хлеб

В какой список записать "хлеб"?

	Продукты

Готово, добавила "хлеб" в "продукты"

	Добавь яйца

В какой список записать "яйца"?

	Продукты

Готово, добавила "яйца" в "продукты"

	Алиса, перечисли список Продукты

продукты:
1. молоко
2. хлеб
3. яйца
```

### На поверхности {#device-test}

Чтобы начать диалог, используйте любое поддерживаемое [Алисой](https://yandex.ru/alice) устройство или сервис. Например, мобильное приложение [Алиса — голосовой помощник](https://play.google.com/store/apps/details?id=com.yandex.alice&hl=ru&gl=US).

### На сайте {#site-test}

В браузере перейдите по адресу, который указан в поле **Служебный домен** вашего API-шлюза, и авторизуйтесь. Загрузится страница «Мои списки». При переходе в любой из списков можно добавить или удалить пункты, а также предоставить доступ к списку другим пользователям.

