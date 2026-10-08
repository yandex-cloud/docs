# Веб-приложение на {{ src-name }} Sites и {{ sf-full-name }}

В этом руководстве демонстрируется пример развёртывания простого веб-приложения с применением сервисов и инструментов:

- Фронтенд - статический сайт на [{{ src-name }} Sites]({{ link-src-docs }}/sourcecraft/concepts/sites).
- Бэкенд - облачная функция [{{ sf-full-name }}]({{ link-docs }}/functions/concepts/function) в связке со шлюзом [{{ api-gw-full-name }}]({{ link-docs }}/api-gateway/concepts/).
- Хранение и работа с кодом - репозиторий [{{ src-name }}]({{ link-src-docs }}/).
- Создание ресурсов {{ yandex-cloud }} - [{{ src-name }} CI/CD]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) и [сервисное подключения {{ src-name }}]({{ link-src-docs }}/sourcecraft/concepts/service-connections) к {{ yandex-cloud }}.

Это веб-приложение подойдёт для разработки и прототипирования или для пэт-проекта. Преимущества такого подхода:

- Не нужно поднимать виртуальную машину или сервер ни для фронтенда, ни для бэкенда.
- Бесплатный хостинг на [{{ src-name }} Sites]({{ link-src-docs }}/sourcecraft/concepts/sites) с доступом по HTTPS (загрузка собственного TLS-сертификата не требуется).
- Уровень нетарифицируемого использования ([free tier]({{ link-docs }}/billing/concepts/serverless-free-tier)) для **{{ sf-full-name }}** и **{{ api-gw-full-name }}** делает их применение бесплатным при небольших нагрузках.
- Бесплатное использование возможностей {{ src-name }} для работы с кодом и CI/CD в рамках [тарифного плана]({{ link-src-docs }}/sourcecraft/pricing#src-plans) **{{ src-name }} Free**.

{% note info %}

Веб-приложение (сайт) публикуется на основе файлов, которые размещены в публичном [репозитории]({{ link-src-docs }}/sourcecraft/concepts/#repos) публичной [организации]({{ link-src-docs }}/sourcecraft/concepts/#org) {{ src-name }}.

Вы можете подтвердить владение сайтом на {{ src-name }} Sites в [Яндекс Вебмастере](https://webmaster.yandex.ru). Подробнее читайте в разделе [Вопросы про {{ src-name }}]({{ link-src-docs }}/sourcecraft/qa/sourcecraft-sites#verify-site-owner).

{% endnote %}

Чтобы создать веб-приложение:

1. [Подготовьтесь к работе](#prepare).
2. [Клонируйте]({{ link-src-docs }}/sourcecraft/operations/repo-clone) (`git clone https://git@git.sourcecraft.dev/examples/sourcecraft-sites-web-app.git`) или [создайте ответвление]({{ link-src-docs }}/sourcecraft/operations/fork-work#create-fork) (форк) [репозитория](https://sourcecraft.dev/examples/sourcecraft-sites-web-app) в свою организацию на {{ src-name }}.
3. [Создайте сервисное подключение]({{ link-src-docs }}/sourcecraft/operations/service-connections) с именем `default-service-connection`.
4. [Вручную запустите]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) рабочий процесс `create-resources` в ветке `master`.
5. [Протестируйте приложение](#test).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их и [снимите](#delete) сайт с публикации.

## Подготовка к работе {#prepare}

1. {% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}
2. Аутентифицируйтесь в {{ src-name }} на [главной странице]({{ link-src-main }}) сервиса или [зарегистрируйтесь]({{ link-src-docs }}/sourcecraft/quickstart#registration).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры веб-приложения входят:
* стоимость использования шлюза ([тарифы {{ api-gw-full-name }}]({{ link-docs }}/api-gateway/pricing)).
* стоимость использования облачной функции ([тарифы {{ sf-full-name }}]({{ link-docs }}/functions/pricing)).

## Проверка работы приложения {#test}

Чтобы открыть приложение, в браузере перейдите по URL-адресу `https://<слаг_организации>.sourcecraft.site/<название_репозитория>`. Если все было настроено правильно, то на открывшейся странице вы увидете поле для ввода имени и кнопку. Введите имя и нажмите кнопку, в результате ниже должна появиться строка с приветствием.

## Удалить ресурсы {{ yandex-cloud }} {#clear-out}

Ресурсы (шлюз и облачную функцию) можно удалить одним из способов:

* Вручную в консоли {{ yandex-cloud }} ([Удалить функцию]({{ link-docs }}/functions/operations/function/function-delete), [удалить API-шлюз]({{ link-docs }}/api-gateway/operations/api-gw-delete)).
* В репозитории [вручную]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) запустить рабочий процесс `delete-resources`.

## Снять сайт с публикации {#delete}

Для снятия сайта с публикации достаточно выполнить одно из действий:

* Сделать репозиторий или организацию приватной.
* Удалить из основной ветки репозитория файл `.sourcecraft/sites.yaml`.

## Полезные ссылки {#see-also}

[Подключение к базе данных {{ ydb-name }} из функции {{ sf-full-name }} на Python]({{ link-docs }}/tutorials/serverless/connect-from-cf)
