# Все методы

{{ yds-full-name }} HTTP API, совместимый с [Amazon Kinesis Data Streams API](https://docs.aws.amazon.com/kinesis/latest/APIReference/Welcome.html), предоставляет следующие методы:

Название метода</br>AWS Kinesis API | Описание | Примечание
--- | --- | ---
AddTagsToStream | Добавляет или обновляет теги для указанного потока данных. | Не&nbsp;поддерживается {{ yds-full-name }}.
[CreateStream](methods/createstream.md) | Создает [поток данных](../concepts/glossary.md#stream-concepts). |
[DecreaseStreamRetentionPeriod](methods/decreasetreamretentionperiod.md) | Уменьшает [время хранения](../concepts/glossary.md#retention-time) сообщений в потоке данных.</br>Доступные варианты времени хранения: 4 часа, 12 часов, 24 часа. |
[DeleteStream](methods/deletestream.md) | Удаляет поток данных, все его [сегменты](../concepts/glossary.md#shard) и данные. |
DeregisterStreamConsumer | Разрегистрирует выделенного потребителя. | Не&nbsp;поддерживается {{ yds-full-name }}.
DescribeLimits | Описывает ограничения на сегменты. | Не&nbsp;поддерживается {{ yds-full-name }}.
[DescribeStream](methods/describestream.md) | Получает описание указанного потока. |
DescribeStreamConsumer | Получает описание указанного выделенного потребителя. | Не&nbsp;поддерживается {{ yds-full-name }}.
DescribeStreamSummary | Получает обобщенное описание указанного потока без списка сегментов. | Не&nbsp;поддерживается {{ yds-full-name }}.
DisableEnhancedMonitoring | Отключает расширенный мониторинг. | Не&nbsp;поддерживается {{ yds-full-name }}.
EnableEnhancedMonitoring | Включает расширенный мониторинг потока для метрик уровня сегментов. | Не&nbsp;поддерживается {{ yds-full-name }}.
[GetRecords](methods/getrecords.md) | Получает сообщения из потока. |
[GetShardIterator](methods/getsharditerator.md) | Получает значение итератора. |
[IncreaseStreamRetentionPeriod](methods/increasestreamretentionperiod.md) | Увеличивает время хранения сообщений в потоке данных.</br>Доступные варианты времени хранения: 4 часа, 12 часов, 24 часа. |
ListShards | Выводит список сегментов и информацию о них. | Не&nbsp;поддерживается {{ yds-full-name }}.
ListStreamConsumers | Выводит список выделенных потребителей, которые зарегистрированы для получения данных из потока, и информацию о них. | Не&nbsp;поддерживается {{ yds-full-name }}.
[ListStreams](methods/liststreams.md) | Выводит список потоков. |
ListTagsForStream | Выводит список тегов для указанного потока. | Не&nbsp;поддерживается {{ yds-full-name }}.
MergeShards | Объединяет два соседних сегмента потока в один. | Не&nbsp;поддерживается {{ yds-full-name }}.
[PutRecord](methods/putrecord.md) | Записывает одно [сообщение](../concepts/glossary.md#message) в поток данных. |
[PutRecords](methods/putrecords.md) | Записывает несколько сообщений в поток данных. |
RegisterStreamConsumer | Регистрирует выделенного потребителя потока. | Не&nbsp;поддерживается {{ yds-full-name }}.
RemoveTagsFromStream | Удаляет теги потока данных. | Не&nbsp;поддерживается {{ yds-full-name }}.
SplitShard | Разделяет сегмент потока на два новых сегмента. | Не&nbsp;поддерживается {{ yds-full-name }}.
StartStreamEncryption | Включает или обновляет шифрование на стороне сервера с помощью ключа AWS KMS для указанного потока. | Не&nbsp;поддерживается {{ yds-full-name }}.
StopStreamEncryption | Отключает шифрование на стороне сервера для указанного потока. | Не&nbsp;поддерживается {{ yds-full-name }}.
SubscribeToShard | Устанавливает соединение между выделенным потребителем и сегментом. | Не&nbsp;поддерживается {{ yds-full-name }}.
[UpdateShardCount](methods/updateshardcount.md) | Обновляет количество сегментов указанного потока.</br>Доступно только увеличение числа сегментов. |
