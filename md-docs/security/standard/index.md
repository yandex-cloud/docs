# Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}, версия {{ security-standard-current-version }}

## Введение {#intro}

Этот документ содержит рекомендации по техническим мерам защиты и помогает выбрать меры обеспечения информационной безопасности (ИБ) при развертывании информационных систем на облачной платформе {{ yandex-cloud }}.

Физическую безопасность дата-центров обеспечивает Платформа {{ yandex-cloud }}, см. [подробное описание мер физической безопасности](../standarts.md). Если критичные данные передаются за пределы {{ yandex-cloud }}, то клиент отвечает за управление физическим доступом для всех мест обработки данных.

Рекомендации и меры обеспечения безопасности в стандарте сопровождаются ссылками на **Инструкции и решения по настройке** безопасных конфигураций ресурсов с помощью штатных средств защиты информации и дополнительных средств защиты, доступных пользователям {{ yandex-cloud }}.

Также стандарт описывает способы и средства проверки выполнения рекомендаций, в том числе:

* с помощью интерфейса консоли управления;
* с помощью интерфейса командной строки {{ yandex-cloud }} CLI;
* вручную.

### Область применения {#application}


Рекомендации предназначены для архитекторов, технических специалистов и специалистов по ИБ, которые используют при создании защищенных облачных систем и разработке политик безопасности для работы на облачной платформе следующие сервисы:

* [{{ alb-full-name }}](../../application-load-balancer/index.md)
* [{{ at-full-name }}](../../audit-trails/index.md)
* [{{ certificate-manager-full-name }}](../../certificate-manager/index.md)
* [{{ dns-full-name }}](../../dns/index.md)
* [{{ cloud-logging-full-name }}](../../logging/index.md)
* [{{ org-full-name }}](../../organization/index.md)
* [{{ compute-full-name }}](../../compute/index.md)
* [{{ container-registry-full-name }}](../../container-registry/index.md)
* [{{ iam-full-name }} ({{ iam-short-name }})](../../iam/index.md)
* [{{ kms-full-name }}](../../kms/index.md)
* [{{ lockbox-full-name }}](../../lockbox/index.md)
* [{{ mch-full-name }}](../../managed-clickhouse/index.md)
* [{{ mgl-full-name }}](../../managed-gitlab/index.md)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.md)
* [{{ mmg-full-name }}](../../storedoc/index.md)
* [{{ mmy-full-name }}](../../managed-mysql/index.md)
* [{{ mpg-full-name }}](../../managed-postgresql/index.md)
* [{{ mrd-full-name }}](../../managed-valkey/index.md)
* [{{ ydb-full-name }}](../../ydb/index.md)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.md)
* [{{ objstorage-full-name }}](../../storage/index.md)
* [{{ resmgr-full-name }}](../../resource-manager/index.md)
* [{{ sws-full-name }}](../../smartwebsecurity/index.md)
* [{{ captcha-full-name }}](../../smartcaptcha/index.md)
* [{{ vpc-full-name }}](../../vpc/index.md)

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
* Безопасность {{ k8s }}.

### Требования и подготовка {#requirements-and-preparation}

Для проверок убедитесь, что:
* установлен и настроен CLI по [инструкции](../../cli/quickstart.md);
* вы вошли в [консоль управления]({{ link-console-main }});
* установлена утилита jq.

Вы можете автоматизировать аудит выполнения всех рекомендаций с помощью [{{ sd-full-name }}](../../security-deck/index.md) — это комплексная CNAPP-платформа, включающая в себя модули:
* [Отслеживания действий команды {{ yandex-cloud }} с ресурсами пользователя](../../security-deck/concepts/access-transparency.md) ({{ atr-name }}).
* [Контроля данных](../../security-deck/concepts/dspm.md) ({{ dspm-name }}).
* [Контроля конфигурации](../../security-deck/concepts/cspm.md) ({{ cspm-name }}).
* [Контроля {{ k8s }}](../../security-deck/concepts/kspm.md) ({{ kspm-name }}).
* [Диагностики доступов](../../security-deck/concepts/ciem.md) ({{ ciem-name }}).
* [Просмотра алертов](../../security-deck/concepts/alerts.md).
* [Портал соответствия требованиям](../../security-deck/concepts/compliance.md).

Сервис также предоставляет [AI-ассистента](../../security-deck/concepts/ai-assistant.md) на базе {{ yagpt-name }} для получения рекомендаций по безопасности.


### Ограничение ответственности {#liability-limit}

В {{ yandex-cloud }} применяется [концепция разделения ответственности](https://yandex.cloud/ru/security/shared-responsibility). Граница разделения ответственности за обеспечение безопасности зависит от сервисов, которые используются системой в облаке, от модели использования этих сервисов ([IaaS](https://yandex.cloud/ru/blog/posts/2022/01/iaas) — инфраструктура как услуга, [PaaS](https://yandex.cloud/ru/blog/posts/2023/03/paas) — платформа как услуга, [SaaS](https://yandex.cloud/ru/blog/posts/2023/03/saas) — программное обеспечение как услуга) и имеющихся у облачного провайдера защитных механизмов и политик.

### Термины и сокращения {#terms}

В настоящем документе используются термины и определения, введенные стандартом ISO/IEC 27000:2018 и ISO/IEC 29100:2011, а также термины, используемые в [глоссарии](../../glossary/index.md) {{ yandex-cloud }}.

### Идентификаторы {#ids}

У проверок есть идентификаторы следующего вида: `ID:IAM1`. Эти идентификаторы используются для создания ссылок на секции стандарта для использования в инструментах класса {{ cspm-full-name }} ({{ cspm-name }}) и не несут никакой иной информации.

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._