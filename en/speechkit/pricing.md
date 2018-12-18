# Yandex SpeechKit pricing

## What goes into the cost of [!KEYREF speechkit-short-name] use {#rules}

The cost of using the SpeechKit API for speech synthesis is calculated from the total number of characters sent to generate speech from text over a calendar month (the reporting period).

[!INCLUDE [pricing-symbol-count](../_includes/pricing-symbol-count.md)]

### Speech recognition use {#rules-stt}

The cost of using the SpeechKit API for speech recognition is calculated from the length of audio files successfully processed by the service during the reporting period. The length of each audio file is measured in 15-second segments and rounded up.

#### Examples {#rules-stt-examples}

- You send a 37-second fragment for speech recognition. Your request is split into three segments: two that are 15 seconds long, and one that is 7 seconds long. The length of the last segment is rounded up to 15 seconds. The final cost of the request is calculated for 45 seconds.
- You made two requests, for 5 and 8 seconds, respectively. The length of each request is rounded up to 15 seconds. The final cost of the request is calculated for 30 seconds.

## Prices until January 1, 2019 {#prices-old}

### Speech synthesis {#prices-tts-old}

| Service | Rate per 1 million characters,<br/>without VAT | Rate per 1 million characters,<br/>with VAT |
| ----- | ----- | ----- |
| Speech synthesis | 152.5424 ₽ | 180.0000 ₽

### Speech recognition {#prices-stt-old}

| Service | Price per<br/>15 sec<br/> segment, without VAT | Price per<br/>15 sec<br/> segment, with VAT |
| ----- | ----- | ----- |
| Speech recognition | 0.1270 ₽ | 0.1500 ₽

## Prices as of January 1, 2019 {#prices}

### Speech synthesis {#prices-tts}

| Service | Rate per 1 million characters,<br/>without VAT | Rate per 1 million characters,<br/>with VAT |
| ----- | ----- | ----- |
| Speech synthesis | 152.5424 ₽ | 183.0508 ₽

### Speech recognition {#prices-stt}

| Service | Price per<br/>15 sec<br/> segment, without VAT | Price per<br/>15 sec<br/> segment, with VAT |
| ----- | ----- | ----- |
| Speech recognition | 0.1270 ₽ | 0.1524 ₽ |

