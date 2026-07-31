[Документация Yandex Cloud](../index.md) > [Yandex Security Deck](index.md) > История изменений

# История изменений в Yandex Security Deck

## Июль 2026 {#july-2026}

* В модулях [CSPM](concepts/cspm.md), [KSPM](concepts/kspm.md) и [Обнаружение угроз](concepts/threat-detector.md) теперь можно [настраивать отображение и сортировку правил](operations/cspm/view-rules.md#general-info) контроля безопасности.
* Появилась [возможность](operations/alerts/view.md) фильтровать алерты по расширенному набору атрибутов.
* Использование модуля [Управление уязвимостями](concepts/vulnerability-management.md) перешло в платное потребление. Подробнее в [правилах тарификации](pricing.md#modules-rules).
* В модуле [KSPM](concepts/kspm.md) реализован [блокирующий режим](operations/kspm/manage-rule-modes.md) для правил типа `admission`, который позволяет запрещать развертывание нагрузок, нарушающих политики безопасности.
* В модуле [CSPM](concepts/cspm.md) появился новый [набор правил](concepts/standard-compliance/ransomware-prevention.md) для снижения рисков атак программ-шифровальщиков (ransomware) и пополнился список правил проверки инфраструктуры на соответствие стандартам безопасности. Новые правила регламентируют парольную политику и контроль исходящего доступа в интернет.
* В модуле [DSPM](concepts/dspm.md):
  * теперь можно подключать [пользовательские словари](concepts/dspm.md#custom-dictionaries) для поиска специфичных чувствительных данных;
  * появились [подписки](pricing.md#starter-rules) с фиксированной стоимостью, которую можно оформить вместо оплаты фактического потребления ресурсов;
  * реализовано [непрерывное сканирование изменений](concepts/dspm.md#change-scaning) для отслеживания появления и изменения чувствительных данных.

## Июнь 2026 {#june-2026}

* Сервис Yandex Security Deck перешел на стадию [General Availability](../overview/concepts/launch-stages.md). Модули [Threat Detection](concepts/threat-detector.md) и Vulnerability Manager и AI-ассистент остаются на стадии [Preview](../overview/concepts/launch-stages.md)
* В модуле [CSPM](concepts/cspm.md) появились новые правила проверки инфраструктуры на соответствие стандартам безопасности. Новые правила регламентируют использование [MFA](rules-reference/cspm.md#userpool-mfa), [ротацию ключей](rules-reference/cspm.md#sa-key-rotation), использование [учетных записей Яндекс ID](rules-reference/cspm.md#yid-organization), отслеживание даты [последней аутентификации сервисных аккаунтов](rules-reference/cspm.md#unused-service-account) и последнего использования [ключей доступа](rules-reference/cspm.md#unused-key).
* В модуле [KSPM](concepts/kspm.md): 
  * в [исключениях](operations/kspm/manage-exceptions.md) теперь можно исключить ресурсы из проверки по типу, имени нагрузки и меткам;
  * реализованы режимы работы правил типа admission;
  * поддержана новая версия Kubernetes®.
* Появилась [возможность](operations/alerts/work.md#update-batch) изменять статус, назначать ответственных и менять критичность сразу для нескольких алертов.
* При создании окружения создается приемник алертов по умолчанию, если пользователь не создает свой приемник алертов. 
* Реализована возможность [активировать и деактивировать окружения](operations/workspaces/index.md) Security Deck.

## Май 2026 {#may-2026}

* В модуле [CSPM](concepts/cspm.md) появился новый [набор правил](concepts/standard-compliance/yc-gost-57580.md) на соответствие стандарту ГОСТ Р 57580 — национальному стандарту безопасности банковских и финансовых операций. 
* В модуле [DSPM](concepts/dspm.md) появилась возможность создавать [области сканирования](operations/dspm/create-data-source.md#change-scaning) из результатов предварительного анализа и непрерывно [отслеживать](concepts/dspm.md#change-scaning) области на предмет появления или изменения чувствительных данных.  
* Расширилась тарифная сетка — теперь вы можете приобрести ежемесячную [подписку](pricing.md#starter-pricing) на модули [CSPM](concepts/cspm.md) и [Threat Detection](concepts/threat-detector.md).
* Все [ошибки](diagnostics/index.md) модулей теперь отображаются в общем интерфейсе ошибок.
* Функциональность поиска чувствительных данных на дисках Яндекс 360 с помощью модуля [DSPM](concepts/dspm.md) стала доступна всем пользователям. Ранее функциональность была доступна только по запросу.

## Апрель 2026 {#april-2026}

* Запущен [Обнаружение угроз](concepts/threat-detector.md) (TD). Модуль находится на стадии [Preview](../overview/concepts/launch-stages.md) и доступен только по запросу.
* В модуле [CSPM](concepts/cspm.md) появились новые правила проверки инфраструктуры на соответствие стандартам безопасности. Новые правила регламентируют [мониторинг событий безопасности](rules-reference/cspm.md#gitlab-audited) инстанса Managed Service for GitLab и управление учетными данными пользователей.
* Появилась возможность вручную [запустить проверку](operations/cspm/check-environment.md) инфраструктуры на соответствие стандартам безопасности в модуле [CSPM](concepts/cspm.md).
* Стало возможным [просматривать и скачивать](operations/dspm/discovery-mode.md) результаты предварительного анализа в модуле [DSPM](concepts/dspm.md).
* На странице алертов от модулей [CSPM](concepts/cspm.md) и [KSPM](concepts/kspm.md) теперь можно [исключить ресурс](operations/alerts/work.md#create-exception) из проверки на соответствие требованиям.

## Март 2026 {#march-2026}
* Запущен модуль [Управление уязвимостями(VM)](concepts/vulnerability-management.md). Модуль находится на стадии [Preview](../overview/concepts/launch-stages.md) и доступен только по запросу.
* В модуле [DSPM](concepts/dspm.md) появилась возможность предварительного [анализа данных](concepts/dspm.md#discovery-mode), хранящихся в бакетах Object Storage в пределах окружения.
* Алерты теперь можно [группировать](./operations/alerts/view.mdsearch) по типу и фильтровать по новым атрибутам.
* В модуле [KSPM](concepts/kspm.md) в [исключениях](operations/kspm/manage-exceptions.md) теперь можно указать объекты через поиск по пространству имен.
* В модуле [CSPM](concepts/cspm.md) появились новые правила проверки инфраструктуры на соответствие стандартам безопасности. Новые правила регламентируют [назначение](rules-reference/cspm.md#check-privileged-roles) привилегированных ролей, [защиту](rules-reference/cspm.md#appsec-ddos-protection-l3) от DDoS-атак на сетевом уровне, [доступ](rules-reference/cspm.md#access) сервисных аккаунтов к кластерам Kubernetes® и избыточные роли сервисных аккаунтов на уровне [организации](rules-reference/cspm.md#sa-privileges-org-roles) и [сервиса](rules-reference/cspm.md#sa-privileges-service-roles). 

## Февраль 2026 {#february-2026}

* Модули [DSPM](concepts/dspm.md), [CSPM](concepts/cspm.md), [KSPM](concepts/kspm.md) и [AI-ассистент](concepts/ai-assistant.md) стали доступны на стадии [Preview](../overview/concepts/launch-stages.md).
* С 2 февраля 2025 года использование модуля [KSPM](concepts/kspm.md) тарифицируется в соответствии с [правилами тарификации](pricing.md#kspm-rules).
* В модуле [CSPM](concepts/cspm.md) поддержаны новые [стандарты безопасности](concepts/cspm.md#standards) — PCI DSS (Payment Card Industry Data Security Standard) и Требования ФСТЭК (Приказ № 21) для защиты персональных данных. 
* В модуле [CSPM](concepts/cspm.md) реализованы новые правила соответствия всем поддержанным в модуле стандартам безопасности.

## Январь 2026 {#january-2026}

* Реализован [API](api-ref/Alert/index.md) для работы с алертами.

## IV квартал 2025 {#q4-2025}

* Добавлена поддержка дисков [Яндекс 360](https://360.yandex.ru/) как [источника сканирования](operations/dspm/create-scan.md#yandex-360) в DSPM.
* Сканирование изображений в модуле [DSPM](concepts/dspm.md) теперь тарифицируется в соответствии с [правилами тарификации](pricing.md#dspm-rules).
* Добавлен [интерфейс проверки соответствия требованиям](concepts/standard-compliance/index.md).

## III квартал 2025 {#q3-2025}

* Запущены модули [KSPM](concepts/kspm.md) и [CSPM](concepts/cspm.md).
* Модули KSPM и CSPM теперь доступны в качестве источников данных для [алертов](concepts/alerts.md).
* Добавлена возможность [создать окружение Security Deck](operations/workspaces/index.md) — контейнер, который содержит настройки и ресурсы модулей, перечень контролируемых ресурсов, параметры контроля и другие настройки.
* Добавлен [AI-ассистент](concepts/ai-assistant.md).
* Для модуля [DSPM](concepts/dspm.md) появились возможности [частичного сканирования](operations/dspm/create-scan.md) и [сканирования по изображениям](operations/dspm/create-scan.md).