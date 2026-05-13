# Руководства по работе с бессерверными технологиями в Yandex Cloud

## Бэкенд на Serverless {#backend}

* [Развертывание веб-приложения с использованием Java Servlet API](java-servlet-todo-list.md)
* [Конвертация видео в GIF на Python](video-converting-queue/index.md)
* [Разработка пользовательской интеграции в API Gateway](api-gw-integration.md)
* [Сокращатель ссылок](serverless-url-shortener/index.md)
* [Разработка CRUD API для сервиса фильмов](movies-database.md)
* [Создание интерактивного serverless-приложения с использованием WebSocket](websocket-app.md)
* [Работа с API-шлюзом по протоколу WebSocket](api-gw-websocket.md)
* [Создание функции Node.js с помощью TypeScript](nodejs-typescript.md)
* [Запуск контейнерного приложения в Yandex Serverless Containers](deploy-app-container.md)
* [Подключение к базе данных Managed Service for YDB из функции Yandex Cloud Functions на Python](connect-from-cf.md)
* [Подключение к базе данных Yandex Managed Service for YDB из функции Yandex Cloud Functions на Node.js](connect-from-cf-nodejs.md)
* [Настройка подключения к Yandex Managed Service for PostgreSQL из контейнера Serverless Containers](container-pg-connect.md)
* [Развертывание веб-приложения с JWT-авторизацией в Yandex API Gateway и аутентификацией в Firebase](jwt-authorizer-firebase.md)
* [Разработка функций в Functions Framework и их развертывание в Yandex Serverless Containers](functions-framework-to-container.md)
* [Канареечный релиз функции Cloud Functions](canary-release.md)
* [Интерактивная отладка функций Yandex Cloud Functions](serverless-live-debug.md)
* [Создание адреса Yandex Cloud Postbox и проверка владения доменом с помощью Terraform](domain-identity-creating.md)
* [Настройка Postfix для отправки через Yandex Cloud Postbox](postfix-integration.md)

## Боты на Serverless {#bots}

* [Как создать чат-бот для Slack](slack-bot-serverless.md)
* [Как создать бота в Telegram](telegram-bot-serverless.md)
* [Разработка Telegram-бота для распознавания текста на изображениях, синтеза и распознавания аудио](recognizer-bot.md)

## ETL на Serverless {#etl}

* [Ввод данных в системы хранения](data-ingestion.md)
* [Хранение журналов работы приложения](log-ingestion.md)
* [Запись данных с устройства в базу данных](data-recording.md)
* [Запись логов балансировщика в PostgreSQL](logging.md)
* [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](data-transfer-direct-to-mch.md)
* [Передача событий Yandex Cloud Postbox в Yandex Data Streams и их анализ с помощью Yandex DataLens](events-from-postbox-to-yds.md)
* [Яндекс Трекер: экспорт и визуализация данных](data-from-tracker.md)
* [Поставка данных из Яндекс Формы в Yandex DataLens с использованием Yandex Cloud Functions и Yandex Query](forms-and-datalens-integration/index.md)
* [Интеграция Yandex Cloud Postbox с внешними системами с помощью вебхуков](postbox-webhook.md)

## Рабочие процессы и автоматизация на Serverless {#automation}

* [Построение пайплайна CI/CD в GitLab](ci-cd-serverless.md)
* [Запуск GitLab Runner в Yandex Serverless Containers](serverless-gitlab-runner.md)
* [Создание триггера для бюджетов, который вызывает функцию Cloud Functions для остановки ВМ](serverless-trigger-budget-vm.md)
* [Автоматическое копирование объектов из одного бакета Yandex Object Storage в другой](bucket-to-bucket-copying.md)
* [Запуск вычислений по расписанию в Yandex DataSphere](regular-launch.md)
* [Регулярное распознавание аудиофайлов из Yandex Object Storage](batch-recognition-stt.md)
* [Развертывание отказоустойчивой архитектуры с прерываемыми виртуальными машинами](nodejs-cron-restart-vm.md)
* [Создание триггеров, которые вызывают функции Cloud Functions для остановки ВМ и отправки уведомлений в Telegram](serverless-trigger-budget-queue-vm-tg.md)
* [Масштабирование группы виртуальных машин по расписанию](vm-scale-scheduled/index.md)
* [Запуск вычислений в Yandex DataSphere с помощью API](batch-code-execution.md)
* [Настройка CI/CD между Yandex Cloud Functions и SourceCraft](ci-cd-sourcecraft-functions.md)
* [Настройка CI/CD между Yandex Cloud Functions и GitHub](ci-cd-github-functions.md)
* [Настройка CI/CD в SourceCraft для развертывания приложения в Yandex Serverless Containers с помощью GitHub Actions](ci-cd-sourcecraft-github-actions.md)
* [Автоматическая загрузка данных в Yandex SpeechSense с помощью Yandex Workflows](auto-upload.md)
* [Настройка реагирования в Yandex Cloud Logging и Yandex Cloud Functions](logging-functions.md)
* [Регулярное распознавание изображений и PDF-документов из бакета Object Storage](vision-ocrrecognizer-storage.md)
* [Настройка рабочего процесса Workflows с интеграцией с Яндекс Трекер, Yandex AI Studio и Yandex Cloud Postbox](tracker-yandexgpt-postbox-integrations.md)

## Интернет вещей {#iot}

* [Мониторинг состояния географически распределенных устройств](datalens.md)
* [Мониторинг показаний датчиков и уведомления о событиях](monitoring.md)
* [Эмуляция множества IoT-устройств](iot-emulation.md)
* [Работа с Yandex IoT Core с устройства Android на языке Java](android-java.md)
* [Работа с Yandex IoT Core на языке C#](c-sharp.md)
* [Работа с Yandex IoT Core на языке Java](java.md)
* [Тестирование доставки сообщения](message-delivery-check.md)
* [Отправить сообщение с использованием Mosquitto](mosquitto-publish.md)
* [Подписать устройство или реестр на получение сообщений с использованием Mosquitto](mosquitto-subscribe.md)

## Интеграция с сервисами Яндекса и Yandex Cloud {#integrations}

* [Защита API Gateway при помощи Smart Web Security](api-gw-sws-integration.md)
* [Создание навыка Алисы](alice-skill.md)
* [Разработка навыка Алисы и сайта с авторизацией](alice-shareable-todolist.md)
* [Использование Yandex API Gateway для настройки синтеза речи в Yandex SpeechKit](speechkit-integrarion-via-agi-gw.md)

## Искусственный интеллект {#ai}

* [Как создать бота в Telegram с поддержкой AI-агента с помощью Yandex Workflows](telegram-ai-bot-workflows.md)
* [Создание AI-агента с помощью функции Yandex Cloud Functions](create-ai-agent-function.md)
* [ИИ-ревью пул-реквестов на GitHub с помощью Yandex Workflows и GitHub Actions](ai-powered-github-pr-review.md)
* [Создание агента на OpenAI Agents SDK со стримингом ответа через веб-сокеты на Yandex Cloud Functions и Yandex API Gateway](streaming-openai-agent.md)

## Отправка писем в Yandex Cloud Postbox с помощью AWS SDK {#postbox-send-aws-sdk}

* [Отправка писем с помощью AWS SDK для платформы .NET Core](send-emails-aws-sdk-csharp.md)
* [Отправка писем с помощью AWS SDK для Go](send-emails-aws-sdk-go.md)
* [Отправка писем с помощью AWS SDK для JavaScript](send-emails-aws-sdk-js.md)
* [Отправка писем с помощью AWS SDK для Python](send-emails-aws-sdk-python.md)