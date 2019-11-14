# Speech synthesis

_Speech synthesis (Text-to-speech, TTS) )_ is the process of generating speech from typed text. SpeechKit can convert any texts in several languages into speech. You can choose the voice type (male or female) and tone.

## Languages {#langs}

- Russian
- English
- Turkish

## Quality of speech synthesis {#accuracy}

The quality of synthesized speech is characterized by its similarity to a human voice and its capacity to convey emotion through intonation.

A highlight of Yandex speech technology is that we do not stitch fragments of real speech together, but train our acoustic model on the speaker's voice. To do this, we use a statistical approach based on recurrent neural networks. This method of speech synthesis may result in a somewhat artificial speech tone. However, the speech sounds smooth and has a natural intonation.

The statistical approach also allows us to change the parameters of existing voices. So you can choose the intonation to pronounce your text.

## SSML support {#ssml}

To get more control over speech synthesis, you can use [Speech Synthesis Markup Language](https://en.wikipedia.org/wiki/Speech_Synthesis_Markup_Language) (SSML). This is an XML-based markup language that lets you set the duration of pauses, the pronunciation of individual sounds, and much more. For more information about supported tags and how to use them, see [{#T}](ssml.md).

#### See also

* [{#T}](request.md)

