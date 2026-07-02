[Документация Yandex Cloud](../../index.md) > [Yandex Security Deck](../index.md) > [Концепции](index.md) > Access Transparency

# Access Transparency

[Access Transparency](https://center.yandex.cloud/security/transparency/) — это автоматизированный инструмент, предназначенный для просмотра аналитической информации о действиях, производимых инженерами Yandex Cloud с ресурсами организации в ходе технического обслуживания, работы с [обращениями](../../support/overview.md) или решения задач безопасности. Этот инструмент позволяет обеспечить прозрачность работы и контроль над действиями инженеров Yandex Cloud.

Чтобы подключить и использовать сервис Access Transparency, ваша [организация](../../organization/quickstart.md) должна быть привязана к [платежному аккаунту](../../billing/concepts/billing-account.md). Чтобы привязать организацию к платежному аккаунту, воспользуйтесь [инструкцией](../../billing/operations/change-organization.md).

Когда к организации будет привязан платежный аккаунт, выберите его в модуле [Access Transparency](https://center.yandex.cloud/security/transparency/).

Для управления подпиской Access Transparency необходима роль `access-transparency.subscriptionManager`. Чтобы указать платежный аккаунт при подключении Access Transparency, потребуется роль `access-transparency.billingProvider`. Обе роли включены в `access-transparency.admin` и `access-transparency.editor`. Подробнее в разделе [Роли для анализа данных Access Transparency](../security/access-transparency-roles.md).

Основные функции Access Transparency:

* Сбор и анализ данных о действиях инженеров Yandex Cloud, произведенных с ресурсами организации.
* Предоставление доступа к вердиктам о безопасности конкретных сессий пользователей.
* Автоматическое оповещение о подозрительных действиях или нарушениях безопасности:

    * Специально обученная модель на базе YandexGPT анализирует логи работы сотрудников Yandex Cloud с ресурсами организации.
    * Если анализ нейросети выявляет небезопасные действия сотрудника Yandex Cloud, автоматически создается обращение для проверки этих действий.
    * Если пользователь не согласен с результатами анализа или оценкой, он может создать эскалацию для проверки сессии специалистом по информационной безопасности Yandex Cloud.