# Сравнение логов событий уровня конфигурации и уровня сервисов

Аудитные логи {{ at-name }} могут содержать два разных типа событий: события уровня конфигурации и события уровня сервисов. Задавать типы собираемых событий, [объект назначения](trail.md#target), [области сбора аудитных логов](trail.md#collecting-area) и [другие настройки](trail.md#trail-settings) можно при [создании](../operations/create-trail.md) или [изменении](../operations/manage-trail.md#update-trail) трейла.

## События уровня конфигурации {#control-plane-events}

К событиям уровня конфигурации относятся действия, связанные с конфигурированием ресурсов {{ yandex-cloud }}. {{ at-name }} по умолчанию регистрирует события уровня конфигурации для всех поддерживаемых сервисов в вашей учетной записи {{ yandex-cloud }}.

К этому типу относятся события, связанные с такими действиями, как создание, изменение или удаление компонентов инфраструктуры, пользователей или политик. Примерами событий уровня конфигурации могут служить создание группы безопасности ВМ, создание федерации в сервисе {{ org-full-name }} или удаление кластера баз данных.

События уровня конфигурации регистрируются в том случае, если в настройках [трейла](trail.md) включен сбор событий уровня конфигурации и задана область сбора аудитных логов.

## События уровня сервисов {#data-plane-events}

К событиям уровня сервисов относятся изменения и действия, которые происходят с данными и ресурсами внутри сервисов {{ yandex-cloud }}. По умолчанию {{ at-name }} не регистрирует события уровня сервисов. Включать сбор аудитных логов уровня сервисов и настраивать область сбора в настройках трейла нужно отдельно для каждого из поддерживаемых сервисов.

Регистрация событий уровня сервисов доступна для следующих сервисов:

* [{{ alb-full-name }}](events-data-plane.md#alb)
* [{{ baremetal-full-name }}](events-data-plane.md#baremetal)
* [{{ certificate-manager-full-name }}](events-data-plane.md#certificate-manager)
* [{{ cloud-desktop-full-name }}](events-data-plane.md#clouddesktop)
* [{{ dns-full-name }}](events-data-plane.md#dns)
* [{{ compute-full-name }}](events-data-plane.md#compute)
* [{{ ai-studio-full-name }}](events-data-plane.md#ai-studio)
* [{{ org-full-name }}](events-data-plane.md#organization)
* [{{ iam-full-name }}](events-data-plane.md#iam)
* [{{ kms-full-name }}](events-data-plane.md#kms)
* [{{ lockbox-full-name }}](events-data-plane.md#lockbox)
* [{{ mkf-full-name }}](events-data-plane.md#mkf)
* [{{ mch-full-name }}](events-data-plane.md#mch)
* [{{ managed-k8s-full-name }}](events-data-plane.md#managed-service-for-kubernetes)
* [{{ mmg-full-name }}](events-data-plane.md#mmg)
* [{{ mmy-full-name }}](events-data-plane.md#mmy)
* [{{ mos-full-name }}](events-data-plane.md#mos)
* [{{ mpg-full-name }}](events-data-plane.md#mpg)
* [{{ mspqr-full-name }}](events-data-plane.md#spqr)
* [{{ mrd-full-name }}](events-data-plane.md#mrd)
* [{{ objstorage-full-name }}](events-data-plane.md#objstorage)
* [{{ sd-full-name }}](events-data-plane.md#security-deck)
* [{{ speechkit-full-name }}](events-data-plane.md#speechkit)
* [{{ speechsense-full-name }}](events-data-plane.md#speechsense)
* [{{ sws-full-name }}](events-data-plane.md#sws)
* [{{ translate-full-name }}](events-data-plane.md#translate)
* [{{ vpc-full-name }}](events-data-plane.md#vpc)
* [{{ vision-full-name }}](events-data-plane.md#vision)
* [{{ wiki-full-name }}](events-data-plane.md#wiki)
* [{{ websql-full-name }}](events-data-plane.md#websql)