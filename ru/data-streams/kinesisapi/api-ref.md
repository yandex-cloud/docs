# Все методы

{{yds-full-name}} HTTP API, совместимый с [Amazon Kinesis Data Streams API](https://docs.aws.amazon.com/kinesis/latest/APIReference/Welcome.html), предоставляет следующие методы:

Название метода</br>AWS Kinesis API | Описание | Примечание
--- | --- | ---
AddTagsToStream | Добавляет или обновляет теги для указанного потока данных. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
[CreateStream](methods/createstream.md) | Создает [поток данных](../concepts/glossary.md#stream-concepts). |
[DecreaseStreamRetentionPeriod](methods/decreasetreamretentionperiod.md) | Уменьшает [время хранения](../concepts/glossary.md#retention-time) сообщений в потоке данных.</br>Доступные варианты времени хранения: 4 часа, 12 часов, 24 часа. |
[DeleteStream](methods/deletestream.md) | Удаляет поток данных, все его [сегменты](../concepts/glossary.md#shard) и данные. |
DeregisterStreamConsumer | Разрегистрирует выделенного потребителя. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
DescribeLimits | Описывает ограничения на сегменты. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
[DescribeStream](methods/describestream.md) | Получает описание указанного потока. |
DescribeStreamConsumer | Получает описание указанного выделенного потребителя. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
DescribeStreamSummary | Получает обобщенное описание указанного потока без списка сегментов. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
DisableEnhancedMonitoring | Отключает расширенный мониторинг. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
EnableEnhancedMonitoring | Включает расширенный мониторинг потока для метрик уровня сегментов. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
[GetRecords](methods/getrecords.md) | Получает сообщения из потока. |
[GetShardIterator](methods/getsharditerator.md) | Получает значение итератора. |
[IncreaseStreamRetentionPeriod](methods/increasestreamretentionperiod.md) | Увеличивает время хранения сообщений в потоке данных.</br>Доступные варианты времени хранения: 4 часа, 12 часов, 24 часа. |
ListShards | Выводит список сегментов и информацию о них. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
ListStreamConsumers | Выводит список выделенных потребителей, которые зарегистрированы для получения данных из потока, и информацию о них. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
[ListStreams](methods/liststreams.md) | Выводит список потоков. |
ListTagsForStream | Выводит список тегов для указанного потока. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
MergeShards | Объединяет два соседних сегмента потока в один. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
[PutRecord](methods/putrecord.md) | Записывает одно [сообщение](../concepts/glossary.md#message) в поток данных. |
[PutRecords](methods/putrecords.md) | Записывает несколько сообщений в поток данных. |
RegisterStreamConsumer | Регистрирует выделенного потребителя потока. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
RemoveTagsFromStream | Удаляет теги потока данных. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
SplitShard | Разделяет сегмент потока на два новых сегмента. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
StartStreamEncryption | Включает или обновляет шифрование на стороне сервера с помощью ключа AWS KMS для указанного потока. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
StopStreamEncryption | Отключает шифрование на стороне сервера для указанного потока. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
SubscribeToShard | Устанавливает соединение между выделенным потребителем и сегментом. | Не&nbsp;поддерживается Yandex&nbsp;Data&nbsp;Streams.
[UpdateShardCount](methods/updateshardcount.md) | Обновляет количество сегментов указанного потока.</br>Доступно только увеличение числа сегментов. |
