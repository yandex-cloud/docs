# Практические руководства Cloud Functions

## Бэкенд на Serverless {#backend}

* [Развертывание веб-приложения с использованием Java Servlet API](java-servlet-todo-list.md)
* [Конвертация видео в GIF на Python](video-converting-queue/index.md)
* [Разработка пользовательской интеграции в API Gateway](api-gw-integration.md)
* [Сокращатель ссылок](serverless-url-shortener/index.md)
* [Создание интерактивного serverless-приложения с использованием WebSocket](websocket-app.md)
* [Создание функции Node.js с помощью TypeScript](nodejs-typescript.md)
* [Подключение к базе данных Yandex Managed Service for YDB из функции Cloud Functions на Python](connect-to-ydb.md)
* [Подключение к базе данных Yandex Managed Service for YDB из функции Cloud Functions на Node.js](connect-to-ydb-nodejs.md)
* [Канареечный релиз функции Cloud Functions](canary-release.md)
* [Интерактивная отладка функций Cloud Functions](serverless-live-debug.md)

## Боты на Serverless {#bots}

* [Как создать чат-бот для Slack](slack-bot-serverless.md)
* [Как создать бота в Telegram](telegram-bot-serverless/index.md)
* [Разработка Telegram-бота для распознавания текста на изображениях, синтеза и распознавания аудио](recognizer-bot.md)

## ETL на Serverless {#etl}

* [Запись данных с устройства в базу данных](data-recording.md)
* [Запись логов балансировщика в PostgreSQL](logging.md)
* [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](data-transfer-direct-to-mch.md)
* [Передача событий Yandex Cloud Postbox в Yandex Data Streams и их анализ с помощью Yandex DataLens](events-from-postbox-to-yds.md)
* [Яндекс Трекер: экспорт и визуализация данных](data-from-tracker.md)
* [Поставка данных из Яндекс Формы в Yandex DataLens с использованием Yandex Cloud Functions и Yandex Query](forms-and-datalens-integration/index.md)
* [Интеграция Yandex Cloud Postbox с внешними системами с помощью вебхуков](postbox-webhook.md)

## Рабочие процессы и автоматизация на Serverless {#automation}

* [Создание триггера для бюджетов, который вызывает функцию Cloud Functions для остановки ВМ](serverless-trigger-budget-vm.md)
* [Автоматическое копирование объектов из одного бакета Yandex Object Storage в другой](bucket-to-bucket.md)
* [Запуск вычислений по расписанию в DataSphere](regular-launch-datasphere.md)
* [Регулярное распознавание аудиофайлов из Yandex Object Storage](batch-recognition-stt.md)
* [Развертывание отказоустойчивой архитектуры с прерываемыми виртуальными машинами](nodejs-cron-restart-vm.md)
* [Создание триггеров, которые вызывают функции Cloud Functions для остановки ВМ и отправки уведомлений в Telegram](serverless-trigger-budget-queue-vm-tg.md)
* [Масштабирование группы виртуальных машин по расписанию](vm-scale-scheduled/index.md)
* [Запуск вычислений в Yandex DataSphere с помощью API](batch-code-execution.md)
* [Настройка CI/CD с SourceCraft](ci-cd-sourcecraft-functions.md)
* [Настройка CI/CD с GitHub](ci-cd-github-functions.md)
* [Настройка реагирования в Yandex Cloud Logging и Cloud Functions](logging-functions.md)
* [Разработка функций в Functions Framework и их развертывание в Yandex Serverless Containers](functions-framework-to-container.md)

## Интернет вещей {#iot}

* [Мониторинг состояния географически распределенных устройств](datalens.md)
* [Мониторинг показаний датчиков и уведомления о событиях](monitoring.md)
* [Эмуляция множества IoT-устройств](iot-emulation.md)

## Интеграция с сервисами Яндекса и Yandex Cloud {#integrations}

* [Разработка навыка Алисы и сайта с авторизацией](alice-shareable-todolist.md)
* [Создание навыка Алисы](alice-skill.md)

## Искусственный интеллект {#ai}

* [Создание AI-агента с помощью функции Cloud Functions](create-ai-agent-function.md)
* [Создание агента на OpenAI Agents SDK со стримингом ответа через веб-сокеты на Cloud Functions и Yandex API Gateway](streaming-openai-agent.md)