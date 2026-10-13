[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Бессерверные технологии](index.md) > Бэкенд на Serverless > Веб-приложение на SourceCraft Sites и Yandex Cloud Functions

# Веб-приложение на SourceCraft Sites и Yandex Cloud Functions

В этом руководстве демонстрируется пример развёртывания простого веб-приложения с применением сервисов и инструментов:

- Фронтенд - статический сайт на [SourceCraft Sites](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/sites).
- Бэкенд - облачная функция [Yandex Cloud Functions](../../functions/concepts/function.md) в связке со шлюзом [Yandex API Gateway](../../api-gateway/concepts/index.md).
- Хранение и работа с кодом - репозиторий [SourceCraft](https://sourcecraft.dev/portal/docs/ru/).
- Создание ресурсов Yandex Cloud - [SourceCraft CI/CD](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd) и [сервисное подключения SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/service-connections) к Yandex Cloud.

Это веб-приложение подойдёт для разработки и прототипирования или для пэт-проекта. Преимущества такого подхода:

- Не нужно поднимать виртуальную машину или сервер ни для фронтенда, ни для бэкенда.
- Бесплатный хостинг на [SourceCraft Sites](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/sites) с доступом по HTTPS (загрузка собственного TLS-сертификата не требуется).
- Уровень нетарифицируемого использования ([free tier](../../billing/concepts/serverless-free-tier.md)) для **Yandex Cloud Functions** и **Yandex API Gateway** делает их применение бесплатным при небольших нагрузках.
- Бесплатное использование возможностей SourceCraft для работы с кодом и CI/CD в рамках [тарифного плана](https://sourcecraft.dev/portal/docs/ru/sourcecraft/pricing#src-plans) **SourceCraft Free**.

{% note info %}

Веб-приложение (сайт) публикуется на основе файлов, которые размещены в публичном [репозитории](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repos) публичной [организации](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#org) SourceCraft.

Вы можете подтвердить владение сайтом на SourceCraft Sites в [Яндекс Вебмастере](https://webmaster.yandex.ru). Подробнее читайте в разделе [Вопросы про SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/qa/sourcecraft-sites#verify-site-owner).

{% endnote %}

Чтобы создать веб-приложение:

1. [Подготовьтесь к работе](#prepare).
2. [Клонируйте](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/repo-clone) (`git clone https://git@git.sourcecraft.dev/examples/sourcecraft-sites-web-app.git`) или [создайте ответвление](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/fork-work#create-fork) (форк) [репозитория](https://sourcecraft.dev/examples/sourcecraft-sites-web-app) в свою организацию на SourceCraft.
3. [Создайте сервисное подключение](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections) с именем `default-service-connection`.
4. [Вручную запустите](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) рабочий процесс `create-resources` в ветке `master`.
5. [Протестируйте приложение](#test).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их и [снимите](#delete) сайт с публикации.

## Подготовка к работе {#prepare}

1. Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
   1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
   1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.
   
   Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).
   
   [Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).
2. Аутентифицируйтесь в SourceCraft на [главной странице](https://sourcecraft.dev) сервиса или [зарегистрируйтесь](https://sourcecraft.dev/portal/docs/ru/sourcecraft/quickstart#registration).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры веб-приложения входят:
* стоимость использования шлюза ([тарифы Yandex API Gateway](../../api-gateway/pricing.md)).
* стоимость использования облачной функции ([тарифы Yandex Cloud Functions](../../functions/pricing.md)).

## Проверка работы приложения {#test}

Чтобы открыть приложение, в браузере перейдите по URL-адресу `https://<слаг_организации>.sourcecraft.site/<название_репозитория>`. Если все было настроено правильно, то на открывшейся странице вы увидете поле для ввода имени и кнопку. Введите имя и нажмите кнопку, в результате ниже должна появиться строка с приветствием.

## Удалить ресурсы Yandex Cloud {#clear-out}

Ресурсы (шлюз и облачную функцию) можно удалить одним из способов:

* Вручную в консоли Yandex Cloud ([Удалить функцию](../../functions/operations/function/function-delete.md), [удалить API-шлюз](../../api-gateway/operations/api-gw-delete.md)).
* В репозитории [вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) запустить рабочий процесс `delete-resources`.

## Снять сайт с публикации {#delete}

Для снятия сайта с публикации достаточно выполнить одно из действий:

* Сделать репозиторий или организацию приватной.
* Удалить из основной ветки репозитория файл `.sourcecraft/sites.yaml`.

## Полезные ссылки {#see-also}

[Подключение к базе данных Managed Service for YDB из функции Yandex Cloud Functions на Python](connect-from-cf.md)