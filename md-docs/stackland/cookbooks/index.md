[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Stackland](../index.md) > Сборник рецептов администратора Stackland > Все рецепты

# Сборник рецептов администратора Stackland

Yandex Cloud Stackland — платформа контейнеризации на базе Kubernetes с интегрированными базовыми компонентами и PaaS-сервисами Yandex Cloud. Это готовое решение для централизованного управления микросервисными, аналитическими и AI-приложениями в on-premises.

С помощью этой серии рецептов вы сможете самостоятельно инсталлировать Stackland и настроить систему для работы в вашей инфраструктуре.

## Проектирование и развертывание инсталляции Stackland {#installation}

Узнаете об архитектуре Stackland, установке компонентов и первичной настройке.

* [Архитектура Yandex Cloud Stackland и роли компонентов](installation/01-architecture-and-components.md)
* [Подготовка к инсталляции](installation/02-installation-preparation.md)
* [Запуск инсталляции](installation/03-installation-launch.md)
* [Диагностика компонентов](installation/04-components-diagnostics.md)
* [Первичная настройка](installation/05-initial-setup.md)

## Запуск команды разработки в инсталляцию {#dev-team-onboarding}

Спроектируете модель доступов и настроите права для участников команды.

* [Проектирование модели доступов](dev-team-onboarding/01-access-model-design.md)
* [Подготовка проекта и пространств имен команды](dev-team-onboarding/02-project-and-namespaces.md)
* [Настройка прав в IAM](dev-team-onboarding/03-iam-permissions.md)
* [Настройка квот](dev-team-onboarding/04-quotas.md)

## Политики, безопасность и эксплуатационные ограничения {#security-policies}

Выясните, как внедрять политики безопасности в кластере Stackland.

* [Внедрение политик безопасности и аудит конфигураций](security-policies/01-security-policies-and-audit.md)

## Обновления Stackland {#updates}

Узнаете, как обновить Stackland: от подготовки кластера до запуска и мониторинга обновления.

* [Обновление кластера](updates/01-cluster-update.md)