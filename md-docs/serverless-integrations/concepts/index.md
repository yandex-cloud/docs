# Обзор сервиса Serverless Integrations

Yandex Serverless Integrations — это сервис для настройки интеграций и управления ими с помощью serverless-технологий в Yandex Cloud.

Serverless Integrations позволяет:
* разрабатывать микросервисные архитектуры без необходимости конфигурировать виртуальные машины;
* создавать и автоматизировать рабочие процессы для реагирования на инциденты безопасности;
* автоматизировать бизнес-операции;
* настраивать пайпланы CI/CD;
* разрабатывать событийно-ориентированные приложения на базе serverless, используя оркестрацию и хореографию, чтобы организовывать взаимодействие между событиями и управлять ими.

## Доступные функциональности {#instruments}

### Workflows {#workflows}

{% note info %}

Workflows находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Выстраивайте и автоматизируйте рабочие процессы при помощи декларативной спецификации Yandex Workflows Language (YaWL).

### EventRouter {#eventrouter}

{% note info %}

EventRouter находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Настраивайте обмен событиями между вашими сервисами и сервисами Yandex Cloud с возможностью их фильтрации, трансформации и маршрутизации.

### API Gateway {#api-gateway}

Создавайте API-шлюзы, которые поддерживают [спецификацию OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) и набор расширений для взаимодействия с сервисами Yandex Cloud. Подробнее см. [документацию API Gateway](../../api-gateway/index.md).