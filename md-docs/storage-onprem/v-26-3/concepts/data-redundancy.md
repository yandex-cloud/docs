[Документация Yandex Cloud](../../../index.md) > [On-premises Yandex Object Storage](../../index.md) > Версия 26.3 > [Концепции](../index.md) > Избыточность данных

# Избыточность данных

В On-premises Yandex Object Storage избыточность данных обеспечивает Angel — компонент слоя хранения MDS2. Схема избыточности задается для контейнера.

## Избыточное кодирование (Erasure Coding) {#erasure-coding}

Схема EC D+P распределяет закодированные данные между `D` информационными и `P` проверочными частями. Для восстановления достаточно любых `D` исправных частей. Новые записи сначала сохраняются в виде полных копий и преобразуются в EC в фоне.

## Репликация {#replication}

Репликация x3 предусматривает хранение трех полных копий данных. Порядок операций согласуется через Raft.

Подробное описание [избыточности](architecture/storage-layer.md#data-redundancy), [записи](architecture/storage-layer.md#write) и [чтения](architecture/storage-layer.md#read) приведено в разделе об Angel. Условия доступности и [восстановления избыточности](architecture/system-characteristics.md#redundancy-recovery) описаны в разделе об отказоустойчивости.