
<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/episode/vplezctzkblzqsa2f3wh?autoplay=0&mute=1" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>


С помощью {{ ml-sdk-full-name }}, [RAG](https://ru.wikipedia.org/wiki/Генерация,_дополненная_поиском) и [{{ assistant-api }}](../../foundation-models/concepts/assistant/index.md) языковые модели могут поддерживать контекст диалога и обращаться к поиску в базе знаний.

В этом руководстве вы создадите чат-ассистента по продаже вин на основе модели {{ yagpt-name }} 5. Используя возможности [function calling](../../foundation-models/concepts/generation/function-call.md) и RAG, ассистент получит доступ к базе данных по винам и регионам, а также прайс-листу с ценами и данными о наличии вин. Настройка ассистента пройдет в ноутбуке {{ ml-platform-full-name }}, общение с ассистентом будет осуществляться через Telegram.

Чтобы создать интеллектуального ассистента для Telegram:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте API-ключ для сервисного аккаунта](#create-key).
1. [Создайте Telegram-бота](#create-bot)
1. [Создайте секреты](#create-secrets).
1. [Клонируйте репозиторий](#clone-repo).
1. [Протестируйте бота](#test-bot).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для создания интеллектуального ассистента входит:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
* плата за [генерацию текста](../../foundation-models/pricing.md) моделью.

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
  1. Введите имя каталога, например `data-folder`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

Для обращения к модели из ноутбука нужно создать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. На панели слева нажмите ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** или введите название сервиса в строке поиска на дашборде.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта, например `gpt-user`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роль `{{ roles-yagpt-user }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог обращаться к модели из ноутбука, добавьте его в список участников проекта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
  1. На вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
  1. Выберите аккаунт `gpt-user` и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% endlist %}

## Создайте API-ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт получил доступ к модели, создайте [API-ключ](../../iam/concepts/authorization/api-key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. На панели слева нажмите ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** или введите название сервиса в строке поиска на дашборде.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `gpt-user`.
  1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** выберите `yc.ai.languageModels.execute`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ.

{% endlist %}

## Создайте Telegram-бота {#create-bot}

1. Откройте чат с ботом [@botfather](https://t.me/botfather).
1. Следуя инструкциям, придумайте имя и ник своему Telegram-боту.
1. После успешного создания бота вы получите ссылку на чат с вашим ботом и токен. Сохраните их для следующих шагов.

## Создайте секреты {#create-secrets}

Чтобы использовать API-ключ, идентификатор каталога и токен доступа к боту из ноутбука, создайте [секреты](../../datasphere/concepts/secrets.md) с соответствующими значениями.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![secret](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.name }}** задайте имя секрета — `api_key`.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.content }}** вставьте идентификатор ключа.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. По аналогии создайте секреты `folder_id` с идентификатором каталога и `tg_token` с токеном Telegram-бота.

## Клонируйте репозиторий {#clone-repo}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** и дождитесь окончания загрузки.
1. На панели слева в разделе ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** создайте или выберите папку, в которой вы хотите разместить клон репозитория, и перейдите в нее.
1. В верхнем меню нажмите **Git** и выберите **Clone a Repository**.
1. В открывшемся окне введите URI репозитория — `https://github.com/yandex-cloud-examples/yc-ai-wine-assistant`.
1. Включите опцию **Download the repository** и нажмите кнопку **Clone**.

## Запустите ноутбук {#run-notebook}

Код ноутбука подключается к модели, дает ей необходимые функции, а также настраивает бота в Telegram.

1. Перейдите в папку клонированного репозитория.
1. Откройте ноутбук `advanced-assistant.ipynb`.
1. Последовательно запускайте ячейки ноутбука. Не запускайте ячейки блока **Удаляем лишнее**, пока не закончите работу с ботом.
1. Последняя ячейка в блоке **Делаем винного ассистента в телеграме** подготовит вашего бота к работе.

## Протестируйте бота {#test-bot}

1. Перейдите по ссылке на чат с вашим ботом, полученной [ранее](#create-bot).
1. Нажмите **START**.
1. Введите свой запрос в поле ввода сообщений. Например:

   ```text
   Какое вино посоветуешь к белому шоколаду?
   ```

   Результат:

   ```text
   К белому шоколаду могут подойти белые и розовые десертные или креплёные вина. Например, можно рассмотреть вина из сортов Шардоне, Семийона, Рислинга или Вионье. Если вас интересует конкретное вино, я могу проверить его наличие и цену в нашем прайс-листе.
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите проект](../../datasphere/operations/projects/delete.md).