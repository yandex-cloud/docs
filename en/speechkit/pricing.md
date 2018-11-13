# Yandex SpeechKit pricing

[!INCLUDE [pricing-intro](../_includes/pricing-intro.md)]

## Speech synthesis {#speechkit-tts}

The cost of using the SpeechKit API for speech synthesis is calculated from the total number of characters sent to generate speech from text over a calendar month (the reporting period). The total number of characters is rounded up to the nearest 1,000 characters.

[!INCLUDE [pricing-symbol-coun](../_includes/pricing-symbol-count.md)]

| Service | Rate per 1 million characters,<br/>without VAT | Rate per 1 million characters,<br/>with VAT |
| ----- | ----- | ----- |
| Speech synthesis | 152.54 ₽ | 180 ₽ |

## Speech recognition {#speechkit-stt}

The cost of using the SpeechKit API for speech recognition is calculated from the length of audio files successfully processed by the service during the reporting period. The length of each audio file is measured in 15-second segments and rounded up.

| Service | Price per<br/>15 sec<br/> segment, without VAT | Price per<br/>15 sec<br/> segment, with VAT |
| ----- | ----- | ----- |
| Speech recognition | 0.127 ₽ | 0.15 ₽ |

### Examples {#examples}

- You send a 37-second fragment for speech recognition. Your request is split into three segments: two that are 15 seconds long, and one that is 7 seconds long. The length of the last segment is rounded up to 15 seconds. The final cost of the request is calculated for 45 seconds.
- You made two requests, for 5 and 8 seconds, respectively. The length of each request is rounded up to 15 seconds. The total cost of the two requests is calculated for 30 seconds.

