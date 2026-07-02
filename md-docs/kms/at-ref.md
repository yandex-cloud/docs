[Документация Yandex Cloud](../index.md) > [Yandex Key Management Service](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Key Management Service поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.kms.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CancelDeleteSymmetricKey` | Отмена ранее запланированного уничтожения ключа
`CancelSymmetricKeyVersionDestruction` | Отмена ранее запланированного уничтожения версии симметричного ключа
`CreateAsymmetricEncryptionKey` | Создание асимметричной ключевой пары шифрования
`CreateAsymmetricSignatureKey` | Создание ключевой пары электронной подписи
`CreateSymmetricKey` | Создание симметричного ключа
`DeleteAsymmetricEncryptionKey` | Изменение асимметричной ключевой пары шифрования
`DeleteAsymmetricSignatureKey` | Изменение ключевой пары электронной подписи
`DeleteSymmetricKey` | Удаление симметричного ключа
`RotateSymmetricKey` | Ротация симметричного ключа
`ScheduleSymmetricKeyVersionDestruction` | Назначение срока уничтожения версии симметричного ключа
`SetAsymmetricEncryptionKeyAccessBindings` | Назначение прав доступа для асимметричной ключевой пары шифрования
`SetAsymmetricSignatureKeyAccessBindings` | Назначение прав доступа для ключевой пары электронной подписи
`SetPrimarySymmetricKeyVersion` | Выбор основной версии симметричного ключа
`SetSymmetricKeyAccessBindings` | Назначение прав доступа для симметричного ключа
`UpdateAsymmetricEncryptionKey` | Изменение асимметричной ключевой пары шифрования
`UpdateAsymmetricSignatureKey` | Изменение ключевой пары электронной подписи
`UpdateSymmetricKey` | Изменение симметричного ключа
`UpdateSymmetricKeyAccessBindings` | Изменение прав доступа для симметричного ключа
`UpdateAsymmetricEncryptionKeyAccessBindings` | Изменение прав доступа для асимметричной ключевой пары шифрования
`asymmetricencryption.CancelAsymmetricEncryptionKeyDeletion` | Отмена удаления асимметричной ключевой пары шифрования
`asymmetricsignature.CancelAsymmetricSignatureKeyDeletion` | Отмена удаления ключевой пары электронной подписи

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`Decrypt` | Расшифрование шифртекста с помощью ключа
`Encrypt` | Шифрование тестовой строки с помощью ключа
`GenerateDataKey` | Формирование ключа с высокой энтропией для шифрования по схеме Envelope Encryption
`ReEncrypt` | Расшифрование шифртекста ключом с предыдущей версией и шифрование расшифрованного текста новой версией этого же ключа