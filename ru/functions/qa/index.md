---
title: "{{ sf-full-name }}. Ответы на вопросы"
description: "Как получить логи моей работы в сервисе {{ sf-full-name }}? Ответы на этот и другие вопросы в данной статье."
---

# Общие вопросы про {{ sf-name }}

{% include [logs](../../_qa/logs.md) %}

#### Как загрузить ZIP-архив с исходным кодом для обновления функции Serverless через CLI? {#version-create}

Чтобы создать версию [функции](../concepts/function.md) из файла с ZIP-архивом, выполните команду:

```bash
yc serverless function version create --source-path
```

Подробнее о загрузке кода читайте в инструкции [{#T}](../../functions/operations/function/version-manage.md).

#### Какого размера должен быть архив с исходным кодом для загрузки в {{ sf-name }}? {#file-size}

Напрямую можно загрузить файл размером до 3,5 МБ. Файл большего размера необходимо [загружать через {{ objstorage-full-name }}](../../storage/operations/objects/upload.md). Подробнее в [документации](../../functions/operations/function/version-manage.md).

#### Я не владелец облака, но мне предоставили доступ. Какие права/роли мне нужны, чтобы я мог опубликовать функцию? {#roles}

Для управления доступом к функции необходимы роли `admin` или `resource-manager.clouds.owner`. Подробнее в [документации](../security/index.md).

#### Как из Node.js-кода в {{ sf-name }} получить доступ к переменной окружения? {#env}

Для доступа к переменным окружения используется глобальная переменная `process.env`. Подробнее в [документации](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env).

#### Какие модули Python можно использовать при работе с {{ sf-name }}? Как подключать новые модули? {#python}

Модули можно загрузить в ZIP-архиве размером до 3,5 МБ. Файл большего размера необходимо [загружать через {{ objstorage-name }}](../../storage/operations/objects/upload.md). Подробнее в [документации](../../functions/operations/function/version-manage.md).

#### Вызов облачных функций для навыков Яндекс Алисы бесплатный. Если я из облачной функции навыка буду вызывать другую свою облачную функцию — это тоже бесплатно? {#alice-pricing}

Такие вызовы будут тарифицироваться согласно [{#T}](../pricing.md).