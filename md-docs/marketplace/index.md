# Yandex Cloud Marketplace

Yandex Cloud Marketplace — это магазин готовых инструментов для разработки, анализа данных, обеспечения безопасности, создания бизнес‑приложений и других задач. Продукты в Marketplace доступны всем пользователям сервисов Yandex Cloud.

Партнеры могут размещать свои продукты в Yandex Cloud Marketplace и зарабатывать на них.

# Yandex Cloud Marketplace

## Партнерам

 - [Начало работы](quickstart.md)

### Пошаговые инструкции

 - [Регистрация](operations/registration.md)

 - [Создание продукта в кабинете партнера](operations/create-product.md)

 - [Создание тарифа](operations/create-tariff.md)

 - [Создание новой версии продукта](operations/create-new-version.md)

 - [Изменение версии продукта](operations/update-version.md)

 - [Создание пробного периода](operations/create-trial-period.md)

 - [Интеграция с License Manager API](operations/license-manager-integration.md)

 - [Создание конфигурации для продукта Cloud Apps](operations/create-configuration.md)

 - [Заявки на доступ к продуктам](operations/access-requests.md)

### Практические руководства

 - [Создание демонстрационного продукта Cloud Apps](tutorials/demo-cloud-apps.md)

### Концепции

 - [Профиль партнера](concepts/publisher.md)

 - [Продукт](concepts/product.md)

 - [Версия](concepts/version.md)

 - [Тариф](concepts/tariff.md)

 - [Подписка](concepts/subscription.md)

#### Требования к продуктам Marketplace

 - [Создание образа продукта на базе Linux](concepts/compute-product.md)

 - [Создание продукта BareMetal на базе Linux](concepts/baremetal-product.md)

 - [Создание продукта для Managed Service for Kubernetes](concepts/kubernetes-product.md)

 - [Тарификация продуктов на основе метрик издателя](concepts/api-usage.md)

 - [Пробный период](concepts/trial-period.md)

 - [Справочник полей, доступных для формы продукта Cloud Apps](concepts/form-fields-ref.md)

 - [Вычисляемые выражения в конфигурации продукта Cloud Apps](concepts/expressions.md)

 - [Управление доступом](security/partners.md)

### Справочник Metering API

 - [Начало работы с API](api-ref/quickstart.md)

#### REST (англ.)

 - [Overview](metering/api-ref/index.md)

##### ImageProductUsage

 - [Overview](metering/api-ref/ImageProductUsage/index.md)

 - [Write](metering/api-ref/ImageProductUsage/write.md)

##### ProductUsage

 - [Overview](metering/api-ref/ProductUsage/index.md)

 - [Write](metering/api-ref/ProductUsage/write.md)

#### gRPC (англ.)

 - [Overview](metering/api-ref/grpc/index.md)

##### ImageProductUsage

 - [Overview](metering/api-ref/grpc/ImageProductUsage/index.md)

 - [Write](metering/api-ref/grpc/ImageProductUsage/write.md)

##### ProductUsage

 - [Overview](metering/api-ref/grpc/ProductUsage/index.md)

 - [Write](metering/api-ref/grpc/ProductUsage/write.md)

### Справочник License Manager API

 - [Начало работы с License Manager API](license-manager/api-ref/quickstart.md)

#### gRPC (англ.)

 - [Overview](license-manager/api-ref/grpc/index.md)

##### Instance

 - [Overview](license-manager/api-ref/grpc/Instance/index.md)

 - [Get](license-manager/api-ref/grpc/Instance/get.md)

 - [List](license-manager/api-ref/grpc/Instance/list.md)

##### Lock

 - [Overview](license-manager/api-ref/grpc/Lock/index.md)

 - [Get](license-manager/api-ref/grpc/Lock/get.md)

 - [GetByInstanceAndResource](license-manager/api-ref/grpc/Lock/getByInstanceAndResource.md)

 - [List](license-manager/api-ref/grpc/Lock/list.md)

 - [Create](license-manager/api-ref/grpc/Lock/create.md)

 - [Ensure](license-manager/api-ref/grpc/Lock/ensure.md)

 - [Delete](license-manager/api-ref/grpc/Lock/delete.md)

##### Operation

 - [Overview](license-manager/api-ref/grpc/Operation/index.md)

 - [Get](license-manager/api-ref/grpc/Operation/get.md)

 - [Cancel](license-manager/api-ref/grpc/Operation/cancel.md)

#### REST (англ.)

 - [Overview](license-manager/api-ref/index.md)

##### Instance

 - [Overview](license-manager/api-ref/Instance/index.md)

 - [Get](license-manager/api-ref/Instance/get.md)

 - [List](license-manager/api-ref/Instance/list.md)

##### Lock

 - [Overview](license-manager/api-ref/Lock/index.md)

 - [Get](license-manager/api-ref/Lock/get.md)

 - [GetByInstanceAndResource](license-manager/api-ref/Lock/getByInstanceAndResource.md)

 - [List](license-manager/api-ref/Lock/list.md)

 - [Create](license-manager/api-ref/Lock/create.md)

 - [Ensure](license-manager/api-ref/Lock/ensure.md)

 - [Delete](license-manager/api-ref/Lock/delete.md)

##### Operation

 - [Overview](license-manager/api-ref/Operation/index.md)

 - [Get](license-manager/api-ref/Operation/get.md)

 - [Cancel](license-manager/api-ref/Operation/cancel.md)

### Справочник License Manager SaaS API

 - [Начало работы с License Manager SaaS API](license-manager/saas/api-ref/quickstart.md)

#### gRPC (англ.)

 - [Overview](license-manager/saas/api-ref/grpc/index.md)

##### Instance

 - [Overview](license-manager/saas/api-ref/grpc/Instance/index.md)

 - [Get](license-manager/saas/api-ref/grpc/Instance/get.md)

 - [GetUserInfo](license-manager/saas/api-ref/grpc/Instance/getUserInfo.md)

##### Lock

 - [Overview](license-manager/saas/api-ref/grpc/Lock/index.md)

 - [Ensure](license-manager/saas/api-ref/grpc/Lock/ensure.md)

 - [Get](license-manager/saas/api-ref/grpc/Lock/get.md)

 - [GetByResourceID](license-manager/saas/api-ref/grpc/Lock/getByResourceID.md)

##### Operation

 - [Overview](license-manager/saas/api-ref/grpc/Operation/index.md)

 - [Get](license-manager/saas/api-ref/grpc/Operation/get.md)

 - [Cancel](license-manager/saas/api-ref/grpc/Operation/cancel.md)

#### REST (англ.)

 - [Overview](license-manager/saas/api-ref/index.md)

##### Instance

 - [Overview](license-manager/saas/api-ref/Instance/index.md)

 - [Get](license-manager/saas/api-ref/Instance/get.md)

 - [GetUserInfo](license-manager/saas/api-ref/Instance/getUserInfo.md)

##### Lock

 - [Overview](license-manager/saas/api-ref/Lock/index.md)

 - [Ensure](license-manager/saas/api-ref/Lock/ensure.md)

 - [Get](license-manager/saas/api-ref/Lock/get.md)

 - [GetByResourceID](license-manager/saas/api-ref/Lock/getByResourceID.md)

##### Operation

 - [Overview](license-manager/saas/api-ref/Operation/index.md)

 - [Get](license-manager/saas/api-ref/Operation/get.md)

 - [Cancel](license-manager/saas/api-ref/Operation/cancel.md)

### Справочник Cloud Apps Workload API

 - [Начало работы с Cloud Apps Workload API](cloudapps/workload/api-ref/quickstart.md)

#### gRPC (англ.)

 - [Overview](workload/api-ref/grpc/index.md)

##### CloudApplication

 - [Overview](workload/api-ref/grpc/CloudApplication/index.md)

 - [Get](workload/api-ref/grpc/CloudApplication/get.md)

 - [ResolveByWorkload](workload/api-ref/grpc/CloudApplication/resolveByWorkload.md)

#### REST (англ.)

 - [Overview](workload/api-ref/index.md)

##### CloudApplication

 - [Overview](workload/api-ref/CloudApplication/index.md)

 - [Get](workload/api-ref/CloudApplication/get.md)

 - [ResolveByWorkload](workload/api-ref/CloudApplication/resolveByWorkload.md)

### Справочник Product Instance Management API

#### REST (англ.)

 - [Overview](pim/saas/api-ref/index.md)

##### Operation

 - [Overview](pim/saas/api-ref/Operation/index.md)

 - [Get](pim/saas/api-ref/Operation/get.md)

 - [Cancel](pim/saas/api-ref/Operation/cancel.md)

##### ProductInstance

 - [Overview](pim/saas/api-ref/ProductInstance/index.md)

 - [Get](pim/saas/api-ref/ProductInstance/get.md)

 - [Claim](pim/saas/api-ref/ProductInstance/claim.md)

#### gRPC (англ.)

 - [Overview](pim/saas/api-ref/grpc/index.md)

##### Operation

 - [Overview](pim/saas/api-ref/grpc/Operation/index.md)

 - [Get](pim/saas/api-ref/grpc/Operation/get.md)

 - [Cancel](pim/saas/api-ref/grpc/Operation/cancel.md)

##### ProductInstance

 - [Overview](pim/saas/api-ref/grpc/ProductInstance/index.md)

 - [Get](pim/saas/api-ref/grpc/ProductInstance/get.md)

 - [Claim](pim/saas/api-ref/grpc/ProductInstance/claim.md)

## Пользователям

 - [Начало работы](operations/users/quickstart.md)

### Пошаговые инструкции

#### Управление подпиской

 - [Покупка подписки](operations/users/buy-subscription.md)

 - [Привязка подписки](operations/users/lock-subscription.md)

 - [Отвязка подписки](operations/users/unlock-subscription.md)

 - [Перемещение подписки](operations/users/move-subscription.md)

 - [Отключение автопродления](operations/users/cancel-subscription.md)

 - [Запрос доступа к продукту](operations/users/access-requests.md)

### Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Развертывание S2S VPN с помощью strongSwan в Yandex Cloud](tutorials/s2s-vpn.md)

 - [Установка Ghost CMS High Availability с помощью Cloud Apps](tutorials/ghost-cms-cloudapp.md)

 - [Установка WordPress High Availability с помощью Cloud Apps](tutorials/wordpress-ha-cloudapp.md)

 - [Установка WordPress с помощью Cloud Apps](tutorials/wordpress-cloudapp.md)

#### Использование продуктов Cloud Marketplace в Managed Service for Kubernetes

 - [Интеграция с Argo CD](tutorials/argo-cd.md)

 - [Интеграция с Crossplane](tutorials/crossplane.md)

 - [Синхронизация с секретами Yandex Lockbox](tutorials/kubernetes-lockbox-secrets.md)

 - [Настройка Fluent Bit для работы с Cloud Logging](tutorials/fluent-bit-logging.md)

 - [Настройка Gateway API](tutorials/gateway-api.md)

 - [Настройка L7-балансировщика Application Load Balancer с помощью Ingress-контроллера](tutorials/alb-ingress-controller.md)

 - [Настройка логирования для L7-балансировщика Application Load Balancer с помощью Ingress-контроллера](tutorials/alb-ingress-controller-log-options.md)

 - [Создание L7-балансировщика с профилем безопасности Smart Web Security через Ingress-контроллер Application Load Balancer](tutorials/alb-ingress-with-sws-profile.md)

 - [Проверка состояния приложений в кластере Managed Service for Kubernetes с помощью L7-балансировщика Application Load Balancer](tutorials/custom-health-checks.md)

 - [Настройка Kyverno & Kyverno Policies](tutorials/kyverno.md)

 - [Использование Metrics Provider для трансляции метрик](tutorials/metrics-provider.md)

 - [Редактирование изображений для сайтов с помощью Thumbor](tutorials/thumbor.md)

 - [Использование Istio](tutorials/istio.md)

 - [Использование HashiCorp Vault для хранения секретов](tutorials/hashicorp-vault.md)

### Концепции

 - [Подписка](concepts/users/subscription.md)

 - [Типы продуктов](concepts/users/products-types.md)

 - [Управление доступом](security/index.md)

 - [Аудитные логи Audit Trails](at-ref.md)