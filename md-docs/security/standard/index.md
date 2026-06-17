# Стандарт по защите облачной инфраструктуры Yandex Cloud, версия 1.4.2

## Введение {#intro}

Этот документ содержит рекомендации по техническим мерам защиты и помогает выбрать меры обеспечения информационной безопасности (ИБ) при развертывании информационных систем на облачной платформе Yandex Cloud.

Физическую безопасность дата-центров обеспечивает Платформа Yandex Cloud, смотрите [подробное описание мер физической безопасности](../standarts.md). Если критичные данные передаются за пределы Yandex Cloud, то клиент отвечает за управление физическим доступом для всех мест обработки данных.

Рекомендации и меры обеспечения безопасности в стандарте сопровождаются ссылками на **Инструкции и решения по настройке** безопасных конфигураций ресурсов с помощью штатных средств защиты информации и дополнительных средств защиты, доступных пользователям Yandex Cloud.

Также стандарт описывает способы и средства проверки выполнения рекомендаций, в том числе:

* с помощью интерфейса консоли управления;
* с помощью интерфейса командной строки Yandex Cloud CLI;
* вручную.

### Область применения {#application}


Рекомендации предназначены для архитекторов, технических специалистов и специалистов по ИБ, которые используют при создании защищенных облачных систем и разработке политик безопасности для работы на облачной платформе следующие сервисы:

* [Yandex Application Load Balancer](../../application-load-balancer/index.md)
* [Yandex Audit Trails](../../audit-trails/index.md)
* [Yandex Certificate Manager](../../certificate-manager/index.md)
* [Yandex Cloud DNS](../../dns/index.md)
* [Yandex Cloud Logging](../../logging/index.md)
* [Yandex Identity Hub](../../organization/index.md)
* [Yandex Compute Cloud](../../compute/index.md)
* [Yandex Container Registry](../../container-registry/index.md)
* [Yandex Identity and Access Management (IAM)](../../iam/index.md)
* [Yandex Key Management Service](../../kms/index.md)
* [Yandex Lockbox](../../lockbox/index.md)
* [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md)
* [Yandex Managed Service for GitLab](../../managed-gitlab/index.md)
* [Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md)
* [Yandex StoreDoc](../../storedoc/index.md)
* [Yandex Managed Service for MySQL®](../../managed-mysql/index.md)
* [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md)
* [Yandex Managed Service for Valkey™](../../managed-valkey/index.md)
* [Yandex Managed Service for YDB](../../ydb/index.md)
* [Yandex Network Load Balancer](../../network-load-balancer/index.md)
* [Yandex Object Storage](../../storage/index.md)
* [Yandex Resource Manager](../../resource-manager/index.md)
* [Yandex Smart Web Security](../../smartwebsecurity/index.md)
* [Yandex SmartCaptcha](../../smartcaptcha/index.md)
* [Yandex Virtual Private Cloud](../../vpc/index.md)

Стандарт можно рассматривать как основу для разработки рекомендаций, специфичных для организации. Не все меры обеспечения ИБ и рекомендации из настоящего документа могут быть применимы. Кроме того, могут потребоваться дополнительные меры и рекомендации, не включенные в настоящий стандарт.

### Структура стандарта {#structure}

Стандарт описывает рекомендации для следующих задач обеспечения безопасности:
* Аутентификация и управление доступом.
* Сетевая безопасность.
* Безопасная конфигурация виртуальной среды.
* Шифрование данных и управление ключами.
* Сбор, мониторинг и анализ аудитных логов.
* Резервное копирование.
* Физическая безопасность.
* Защита приложений.
* Безопасность Kubernetes.

### Требования и подготовка {#requirements-and-preparation}

Для проверок убедитесь, что:
* установлен и настроен CLI по [инструкции](../../cli/quickstart.md);
* вы вошли в [консоль управления](https://console.yandex.cloud);
* установлена утилита jq.

Вы можете автоматизировать аудит выполнения всех рекомендаций с помощью [Yandex Security Deck](../../security-deck/index.md) — это комплексная CNAPP-платформа, включающая в себя модули:
* [Отслеживания действий команды Yandex Cloud с ресурсами пользователя](../../security-deck/concepts/access-transparency.md) (Access Transparency).
* [Контроля данных](../../security-deck/concepts/dspm.md) (DSPM).
* [Контроля конфигурации](../../security-deck/concepts/cspm.md) (CSPM).
* [Контроля Kubernetes](../../security-deck/concepts/kspm.md) (KSPM).
* [Диагностики доступов](../../security-deck/concepts/ciem.md) (CIEM).
* [Просмотра алертов](../../security-deck/concepts/alerts.md).
* [Портал соответствия требованиям](../../security-deck/concepts/compliance.md).

Сервис также предоставляет [AI-ассистента](../../security-deck/concepts/ai-assistant.md) на базе YandexGPT для получения рекомендаций по безопасности.


### Ограничение ответственности {#liability-limit}

В Yandex Cloud применяется [концепция разделения ответственности](https://yandex.cloud/ru/security/shared-responsibility). Граница разделения ответственности за обеспечение безопасности зависит от сервисов, которые используются системой в облаке, от модели использования этих сервисов ([IaaS](https://yandex.cloud/ru/blog/posts/2022/01/iaas) — инфраструктура как услуга, [PaaS](https://yandex.cloud/ru/blog/posts/2023/03/paas) — платформа как услуга, [SaaS](https://yandex.cloud/ru/blog/posts/2023/03/saas) — программное обеспечение как услуга) и имеющихся у облачного провайдера защитных механизмов и политик.

### Термины и сокращения {#terms}

В настоящем документе используются термины и определения, введенные стандартом ISO/IEC 27000:2018 и ISO/IEC 29100:2011, а также термины, используемые в [глоссарии](../../glossary/index.md) Yandex Cloud.

### Идентификаторы {#ids}

У проверок есть идентификаторы следующего вида: `ID:IAM1`. Эти идентификаторы используются для создания ссылок на секции стандарта для использования в инструментах класса Cloud Security Posture Management (CSPM) и не несут никакой иной информации.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._