# Speech recognition

_Speech recognition (speech-to-text, STT)_ is the process of converting speech to text.

The service can recognize speech in several languages:

* Russian
* English
* Turkish

## Recognition methods {#stt-ways}

There are three recognition methods:

1. [Recognition of short audio files](request.md).
1. [Recognition of long audio files](transcribation.md). _Recognition of long audio files is at the [Preview stage](../../overview/concepts/launch-stages)._
1. [Data streaming recognition](streaming.md).

## Recognition process {#process}

Audio is recognized in three stages:

1. Words are detected. There are usually several possible words recognized (or hypotheses).
1. Hypotheses are checked using the language model. The model validates to what extent a new word is consistent with other words that have already been recognized.
1. The recognized text is processed: numbers are converted to digits, certain punctuation marks (such as hyphens) are added, and so on. The converted text is the final recognition result that is sent in the response body.

## Recognition accuracy {#speed_and_accuracy}

To increase the accuracy of recognition, specify the language model that the service should use. The model should match the speech topic.

The accuracy of speech recognition is also affected by:

* Original sound quality.
* Audio encoding quality.
* Speech intelligibility and rate.
* Utterance complexity and length.

#### See also

* [[!TITLE]](formats.md)
* [[!TITLE]](models.md)
* [[!TITLE]](request.md)
* [[!TITLE]](streaming.md)
* [[!TITLE]](transcribation.md)
* [Yandex speech technologies (a post on Habrahabr, in Russian)](https://habrahabr.ru/company/yandex/blog/243813/)
* [Under the hood of Yandex.SpeechKit (a post on Habrahabr, in Russian)](https://habrahabr.ru/company/yandex/blog/198556/)

