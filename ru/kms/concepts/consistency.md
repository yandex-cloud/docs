# Консистентность ключей

Методы [encrypt](../api-ref/SymmetricCrypto/encrypt), [decrypt](../api-ref/SymmetricCrypto/decrypt) и [reEncrypt](../api-ref/SymmetricCrypto/reEncrypt) являются eventually consistent операциями — изменения, которые они произвели, становятся видимыми с задержкой **до трех часов**.

[Eventually consistent](https://en.wikipedia.org/wiki/Eventual_consistency) операции, изменения проявляются с задержкой **до трех часов**:
* Ротация ключа (автоматическая и ручная).
* Изменение основной версии ключа.
* Изменение статуса ключа на `Inactive`.
* Запланирование уничтожения версии ключа.
* Удаление ключа.

[Strongly consistent](https://en.wikipedia.org/wiki/Strong_consistency) операции, изменения проявляются без задержки:
* Создание ключа.
* Изменение статуса ключа на `Active`.
* Отмена удаления версии ключа, запланированной на удаление (статус версии `Scheduled For Destruction`).

{% note info %}

Если вы хотите оперативно ограничить доступ к ключу, отзовите роли, необходимые для использования ключа при шифровании и расшифровке данных. Подробнее об этом читайте в разделе [{#T}](../security/index.md).

{% endnote %}