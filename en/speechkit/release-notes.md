# YC SpeechKit releases

{{ speechkit-name }} provides updates based on the system model and version.

### For recognition {#for-sst}

For a detailed description of the available versions, see [Recognition models](stt/models.md).

### For synthesis {#for-tts}

In speech synthesis, the service provides [two types of voices](tts/voices.md): standard and premium. Premium voices use new speech synthesis technology.

For more information about voice models, see [About the technology](tts/index.md#voices).

## Current version {#current}

For information about synthesis model updates, see [{#T}](release-notes-tts.md).

For information about recognition model updates, see [{#T}](release-notes-stt.md).

## Previous versions {#previous}

### Release 30.09.21 {#300921}

Major upgrade of premium voices available in the REST API. Voice updates are available by the tags `alena:rc` and `filipp:rc`.

Various improvements in synthesis quality, including the synthesis of questions. Fixed a rare problem with looping synthesis.

For testing purposes, a function for adding stress to specific words is available. It allows you to better control intonation, especially when synthesizing questions. To add a stress after a word that needs to be emphasized, add `<[accented]>`. For example, in `Are you glad <[accented]> to see me?`, the word **glad** is emphasized.

### Release 09.03.21 {#0903}

In streaming speech recognition, transcription, and short audio recognition by the `general:rc` tag, a new version of the _Demosthenes_ model is now available. It features improved basic recognition quality and recognizes names of healthcare professions and words related to jewelry.

We invite you to join in testing the version. We'll be grateful for your feedback.

#### Version availability by tags {#tags-0903}

In transcription only:

* `hqa`: The _Amati_ version.

In streaming, transcription, and short audio recognition:

* `general`: The _Galen_ version.
* `general:rc`: The _Demosthenes_ version.
* `general:deprecated`: The _Zeno_ version.

### Release 26.02.21 {#2602}

In transcription by the `hqa` model tag, a new version named _Guarneri_ is now available. It features greatly improved recognition quality.

#### Version availability by tags {#tags-2602}

In transcription only:

* `hqa`: The _Guarneri_ version.

In streaming, transcription, and short audio recognition:

* `general`: The _Galen_ version.
* `general:rc`: The _Galen_ version.
* `general:deprecated`: The _Zeno_ version.

### Release 03.02.21 {#0302}

The _Galen_ version of the basic recognition model was tested successfully and is the main version of the recognition model as of February 3.

#### Version availability by tags {#tags-0302}

In transcription only:

* `hqa`: The _Amati_ version.

In streaming, transcription, and short audio recognition:

* `general`: The _Galen_ version.
* `general:rc`: The _Galen_ version.
* `general:deprecated`: The _Zeno_ version.

### Release 14.12.20 {#1412}

In transcription by the `hqa` model tag, a new version named _Amati_ is now available. Issues have been fixed where silence was recognized instead of speech. Text recognition for news and medicine subject domains has been improved.

#### Version availability by tags {#tags-1412}

In transcription only:

* `hqa`: The _Amati_ version.

In streaming, transcription, and short audio recognition:

* `general`: _Zeno_ version.
* `general:rc`: The _Galen_ version.
* `general:deprecated`: The _Anaximander_ version.

### Release 01.12.20 {#0112}

In streaming, transcription, and short audio recognition by the `general:rc` tag, a new version of the _Galen_ model is now available. It provides a significantly better basic recognition quality and recognizes words related to COVID-19.

#### Version availability by tags {#tags-0112}

In transcription only:

* `hqa`: The _Stradivarius_ version.

In streaming, transcription, and short audio recognition:

* `general`: _Zeno_ version.
* `general:rc`: The _Galen_ version.
* `general:deprecated`: The _Anaximander_ version.

### Release 24.11.20 {#2411}

After successful testing, the _Zeno_ version is now the main released version of the `general` model in streaming, transcription, and short audio recognition.

#### Version availability by tags {#tags-2411}

In transcription only:

* `hqa`: The _Stradivarius_ version.

In streaming, transcription, and short audio recognition:

* `general` and `general:rc`: _Zeno_ version.
* `general:deprecated`: The _Anaximander_ version.

### Release 17.11.20 {#1711}

Numerous corrections in the pronunciation of individual words thanks to the improved normalization. Declension of numerals fixed. A new version of the `alena` premium voice is now available by the `alena` tag.

#### Version availability by tags {#tags-1711}

No changes.

### Release 26.10.20 {#2610}

A next-generation recognition model is available in transcription: `hqa`. This model has a richer vocabulary, so recognition results are much better and more understandable to readers. The difference is especially noticeable with long audio recognition.

#### Version availability by tags {#tags-2610}

In transcription:

* `hqa`: The _Stradivarius_ version.
* `general`: _Anaximander_ version.
* `general:rc`: The _Zeno_ version.
* `general:deprecated`: The _Marcus Aurelius_ version.

In streaming and short audio recognition: no changes.

### Release 12.10.20 {#1210}

The new version provides significantly better basic recognition quality. A new version of the `general` model is now available in streaming, transcription, and short audio recognition.

#### Version availability by tags {#tags-1210}

* `general`: _Anaximander_ version.
* `general:rc`: The _Zeno_ version.
* `general:deprecated`: The _Marcus Aurelius_ version.

### Release 18.08.20 {#1808}

Update for transcription in the *Anaximander* version:

* Improved handling of dense speech flows, having no detectable pauses in speech for more than 30 seconds.
* Timing fixed.
* Fixed an error with partial recognition results arriving after the final result.

The acoustic and language properties of the model have not changed.

#### Version availability by tags {#tags-1808}

These versions are available for streaming recognition, transcription, and short audio recognition:

* `general`: _Anaximander_ version.
* `general:rc`: _Anaximander_ version (updated).
* `general:deprecated`: _Marcus Aurelius_ version.

### Release 21.07.20 {#2107}

_Anaximander_ is now the main operating version for streaming recognition, transcription, and short audio recognition.

#### Version availability by tags {#tags-2107}

* `general` and `general:rc`: _Anaximander_ version.
* `general:deprecated`: _Marcus Aurelius_ version.

### Release 27.05.20 {#2705}

New versions of the `general` model are now available in transcription and short audio recognition.

#### Version availability by tags {#tags-2705}

Available versions by tag:

* `general:rc`: The _Anaximander_ version.
* `general` and `general:deprecated`: The _Marcus Aurelius version_.

Versions of the `general` model available for streaming recognition:

* `general`: The _Marcus Aurelius_ version.
* `general:rc`: The _Anaximander_ version.
* `general:deprecated`: The _Diogenes_ version.

### Release 15.05.20 {#1505}

For streaming speech recognition, the new version of the _Anaximander_ model is now available with the `general:rc` tag.

#### Version availability by tags {#tags-1505}

* `general`: The _Marcus Aurelius_ version.
* `general:rc`: The _Anaximander_ version.
* `general:deprecated`: The _Diogenes_ version.

The versions for short and long audio recognition remain unchanged.

### Release 16.04.20 {#1604}

For streaming speech recognition by the `general` tag, a new version of the _Marcus Aurelius_ model is now available.

#### Version availability by tags {#tags-1604}

* `general` and `general:rc:` The _Marcus Aurelius_ version.
* `general:deprecated`: The _Diogenes_ version.

The versions for short and long audio recognition available with the `general` tag remain unchanged.