---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Speech recognition

_Speech recognition (speech-to-text, STT)_ is the process of converting speech to text.

The service can recognize speech in several languages:

* Russian
* English
* Turkish

## Recognition methods {#stt-ways}

There are three recognition methods:

1. [Recognition of short audio fragments](request.md). This is suitable for recognizing small single-channel audio fragments.

1. [Streaming mode](streaming.md) for short audio recognition. This allows you to send audio fragments and get results, including intermediate recognition results, over a single connection.

1. [Recognition of long audio fragments](transcribation.md). This lets you recognize long multi-channel audio recordings, but the response may be slower.

    For now, you can only recognize long audio in Russian.

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

#### See also {#see-also}

* [{#T}](formats.md)
* [{#T}](models.md)
* [{#T}](request.md)
* [{#T}](streaming.md)
* [{#T}](transcribation.md)

