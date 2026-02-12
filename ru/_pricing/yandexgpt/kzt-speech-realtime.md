| Услуга | Цена за единицу тарификации, вкл. НДС     |
|---------------------------|-----------------------------------------|
| Входящее аудио, за 1 секунду | {{ sku|KZT|foundation_models.realtime_audio.input.v1|string }} |
| Исходящее аудио, за 1 секунду | {{ sku|KZT|foundation_models.realtime_audio.output.v1|string }} |
| Генерация текста (входящие и исходящие токены), за 1000 токенов | {% calc [currency=KZT] 4 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} ^1^ |