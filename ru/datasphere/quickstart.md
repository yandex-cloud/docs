# Как начать работать с {{ ml-platform-name }}

{{ ml-platform-full-name }} — среда для ML-разработки полного цикла, которая сочетает в себе привычные IDE, технологию бессерверных вычислений и возможность бесшовного использования разных конфигураций вычислительных ресурсов {{ yandex-cloud }}. {{ ml-platform-full-name }} является частью платформы данных и предоставляет широкие возможности для простого взаимодействия с сервисами {{ yandex-cloud }}. В качестве IDE {{ ml-platform-name }} предоставляет [{{ jlab }}® Notebook](https://jupyter.org/).

В этом разделе вы научитесь:
1. [Создавать проект](#create-project).
1. [Запускать проект](#start-project).
1. [Настраивать окружение](#install-dependencies).
1. [Загружать данные в проект](#download-data). 
1. [Запускать обучение](#start-ml).
1. [Делиться результатами](#share-with-community).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Откройте [главную страницу]({{ link-datasphere-main }}) {{ ml-platform-name }}.
1. Примите пользовательское соглашение.
1. Выберите организацию, в которой вы будете работать с {{ ml-platform-name }}, или создайте новую.

## Создайте проект {#create-project}

{% include [create-project](../_includes/datasphere/ui-create-project.md) %}

## Запустите проект {#start-project}

{% include [start-project](../_includes/datasphere/ui-start-project.md) %}

## Настройте окружение {#install-dependencies}

{% include [install-dependencies-intro](../_includes/datasphere/install-dependencies-intro.md) %}

{% include [install-dependencies-steps](../_includes/datasphere/install-dependencies-steps.md) %}

Вы также можете настроить окружение для выполнения вашего кода, [используя Docker-образы](operations/user-images.md).

## Загрузите данные в проект {#download-data}

{% include [download-data](../_includes/datasphere/download-data.md) %}

## Запустите обучение {#start-ml}

{% include [start-ml](../_includes/datasphere/start-ml.md) %}

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](concepts/index.md).
* [Посмотрите другие инструкции по работе с сервисом](operations/index.md).
* [Разверните обученную модель как сервис](concepts/deploy/index.md).