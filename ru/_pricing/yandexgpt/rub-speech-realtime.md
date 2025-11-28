| Услуга                            | Цена за единицу тарификации, <br>вкл. НДС     |
|-----------------------------------|-----------------------------------------|
| Входящее аудио, за 1 секунду | {{ sku|RUB|foundation_models.realtime_audio.input.v1|string }} |
| Исходящее аудио, за 1 секунду | {{ sku|RUB|foundation_models.realtime_audio.output.v1|string }} |
| Генерация текста, за 1000 токенов | {% calc [currency=RUB] 4 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} |