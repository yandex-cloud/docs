#### Квоты {#vision-quotas}

Вид ограничения | Значение
----- | -----
Количество запросов в секунду, [синхронный режим](../vision/ocr/api-ref/TextRecognition/index.md) | 1
Количество запросов в секунду, [асинхронный режим](../vision/ocr/api-ref/TextRecognitionAsync/index.md) | 10
Количество запросов в секунду, асинхронный режим (получение статуса операции) | 50
Количество запросов в секунду, асинхронный режим (получение ответа) | 50

#### Лимиты {#vision-limits}

Вид ограничения | Значение
----- | -----
Срок хранения результатов распознавания на сервере | 3 суток
Максимальный размер файла для [OCR API](../vision/ocr/api-ref/index.md) | {{ ocr-max-filesize }}
Максимальный размер изображения | 20 мегапикселей (длина × ширина)
Максимальное количество страниц в PDF-файле при работе с [OCR API в асинхронном режиме](../vision/ocr/api-ref/TextRecognitionAsync/index.md) | 200