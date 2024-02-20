---
editable: false
sourcePath: en/_api-ref/ai/tts/v3/tts-v3/api-ref/Synthesizer/utteranceSynthesis.md
---

# SpeechKit Synthesis Service API v3, REST: Synthesizer.utteranceSynthesis
Synthesizing text into speech.
 

 
## HTTP request {#https-request}
```
POST https://tts.{{ api-host }}/tts/v3/utteranceSynthesis
```
 
## Body parameters {#body_params}
 
```json 
{
  "model": "string",
  "hints": [
    {

      // `hints[]` includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`
      "voice": "string",
      "audioTemplate": {
        "audio": {
          "audioSpec": {

            // `hints[].audioTemplate.audio.audioSpec` includes only one of the fields `rawAudio`, `containerAudio`
            "rawAudio": {
              "audioEncoding": "string",
              "sampleRateHertz": "string"
            },
            "containerAudio": {
              "containerAudioType": "string"
            },
            // end of the list of possible fields`hints[].audioTemplate.audio.audioSpec`

          },
          "content": "string"
        },
        "textTemplate": {
          "textTemplate": "string",
          "variables": [
            {
              "variableName": "string",
              "variableValue": "string"
            }
          ]
        },
        "variables": [
          {
            "variableName": "string",
            "variableStartMs": "string",
            "variableLengthMs": "string"
          }
        ]
      },
      "speed": "number",
      "volume": "number",
      "role": "string",
      "pitchShift": "number",
      "duration": {
        "policy": "string",
        "durationMs": "string"
      },
      // end of the list of possible fields`hints[]`

    }
  ],
  "outputAudioSpec": {

    // `outputAudioSpec` includes only one of the fields `rawAudio`, `containerAudio`
    "rawAudio": {
      "audioEncoding": "string",
      "sampleRateHertz": "string"
    },
    "containerAudio": {
      "containerAudioType": "string"
    },
    // end of the list of possible fields`outputAudioSpec`

  },
  "loudnessNormalizationType": "string",
  "unsafeMode": true,

  //  includes only one of the fields `text`, `textTemplate`
  "text": "string",
  "textTemplate": {
    "textTemplate": "string",
    "variables": [
      {
        "variableName": "string",
        "variableValue": "string"
      }
    ]
  },
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
model | **string**<br><p>The name of the model. Specifies basic synthesis functionality. Currently should be empty. Do not use it.</p> 
hints[] | **object**<br><p>Optional hints for synthesis.</p> 
hints[].<br>voice | **string** <br>`hints[]` includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`<br><br><p>Name of speaker to use.</p> 
hints[].<br>audioTemplate | **object**<br>Template for synthesizing. <br>`hints[]` includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`<br>
hints[].<br>audioTemplate.<br>audio | **object**<br><p>Audio file.</p> 
hints[].<br>audioTemplate.<br>audio.<br>audioSpec | **object**<br>Optional. Default: 22050 Hz, linear 16-bit signed little-endian PCM, with WAV header
hints[].<br>audioTemplate.<br>audio.<br>audioSpec.<br>rawAudio | **object**<br>The audio format specified in request parameters. <br>`hints[].audioTemplate.audio.audioSpec` includes only one of the fields `rawAudio`, `containerAudio`<br>
hints[].<br>audioTemplate.<br>audio.<br>audioSpec.<br>rawAudio.<br>audioEncoding | **string**<br><p>Encoding type.</p> <ul> <li>LINEAR16_PCM: Audio bit depth 16-bit signed little-endian (Linear PCM).</li> </ul> 
hints[].<br>audioTemplate.<br>audio.<br>audioSpec.<br>rawAudio.<br>sampleRateHertz | **string** (int64)<br><p>Sampling frequency of the signal.</p> 
hints[].<br>audioTemplate.<br>audio.<br>audioSpec.<br>containerAudio | **object**<br>The audio format specified inside the container metadata. <br>`hints[].audioTemplate.audio.audioSpec` includes only one of the fields `rawAudio`, `containerAudio`<br>
hints[].<br>audioTemplate.<br>audio.<br>audioSpec.<br>containerAudio.<br>containerAudioType | **string**<br><ul> <li>WAV: Audio bit depth 16-bit signed little-endian (Linear PCM).</li> <li>OGG_OPUS: Data is encoded using the OPUS audio codec and compressed using the OGG container format.</li> <li>MP3: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format.</li> </ul> 
hints[].<br>audioTemplate.<br>audio.<br>content | **string** (byte)<br><p>Bytes with audio data.</p> 
hints[].<br>audioTemplate.<br>textTemplate | **object**<br><p>Template and description of its variables.</p> 
hints[].<br>audioTemplate.<br>textTemplate.<br>textTemplate | **string**<br><p>Template text.</p> <p>Sample:``The {animal} goes to the {place}.``</p> 
hints[].<br>audioTemplate.<br>textTemplate.<br>variables[] | **object**<br><p>Defining variables in template text.</p> <p>Sample: ``{animal: cat, place: forest}``</p> 
hints[].<br>audioTemplate.<br>textTemplate.<br>variables[].<br>variableName | **string**<br><p>The name of the variable.</p> 
hints[].<br>audioTemplate.<br>textTemplate.<br>variables[].<br>variableValue | **string**<br><p>The text of the variable.</p> 
hints[].<br>audioTemplate.<br>variables[] | **object**<br><p>Describing variables in audio.</p> 
hints[].<br>audioTemplate.<br>variables[].<br>variableName | **string**<br><p>The name of the variable.</p> 
hints[].<br>audioTemplate.<br>variables[].<br>variableStartMs | **string** (int64)<br><p>Start time of the variable in milliseconds.</p> 
hints[].<br>audioTemplate.<br>variables[].<br>variableLengthMs | **string** (int64)<br><p>Length of the variable in milliseconds.</p> 
hints[].<br>speed | **number** (double) <br>`hints[]` includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`<br><br><p>Hint to change speed.</p> 
hints[].<br>volume | **number** (double) <br>`hints[]` includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`<br><br><p>Hint to regulate normalization level.</p> <ul> <li>For ``MAX_PEAK`` loudness_normalization_type: volume changes in a range (0;1], default value is 0.7.</li> <li>For ``LUFS`` loudness_normalization_type: volume changes in a range [-145;0), default value is -19.</li> </ul> 
hints[].<br>role | **string** <br>`hints[]` includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`<br><br><p>Hint to specify pronunciation character for the speaker.</p> 
hints[].<br>pitchShift | **number** (double) <br>`hints[]` includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`<br><br><p>Hint to increase (or decrease) speaker's pitch, measured in Hz. Valid values are in range [-1000;1000], default value is 0.</p> 
hints[].<br>duration | **object**<br>Hint to limit both minimum and maximum audio duration. <br>`hints[]` includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`<br>
hints[].<br>duration.<br>policy | **string**<br><p>Type of duration constraint.</p> <ul> <li>EXACT_DURATION: Limit audio duration to exact value.</li> <li>MIN_DURATION: Limit the minimum audio duration.</li> <li>MAX_DURATION: Limit the maximum audio duration.</li> </ul> 
hints[].<br>duration.<br>durationMs | **string** (int64)<br><p>Constraint on audio duration in milliseconds.</p> 
outputAudioSpec | **object**<br>Description of the audio format.
outputAudioSpec.<br>rawAudio | **object**<br>The audio format specified in request parameters. <br>`outputAudioSpec` includes only one of the fields `rawAudio`, `containerAudio`<br>
outputAudioSpec.<br>rawAudio.<br>audioEncoding | **string**<br><p>Encoding type.</p> <ul> <li>LINEAR16_PCM: Audio bit depth 16-bit signed little-endian (Linear PCM).</li> </ul> 
outputAudioSpec.<br>rawAudio.<br>sampleRateHertz | **string** (int64)<br><p>Sampling frequency of the signal.</p> 
outputAudioSpec.<br>containerAudio | **object**<br>The audio format specified inside the container metadata. <br>`outputAudioSpec` includes only one of the fields `rawAudio`, `containerAudio`<br>
outputAudioSpec.<br>containerAudio.<br>containerAudioType | **string**<br><ul> <li>WAV: Audio bit depth 16-bit signed little-endian (Linear PCM).</li> <li>OGG_OPUS: Data is encoded using the OPUS audio codec and compressed using the OGG container format.</li> <li>MP3: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format.</li> </ul> 
loudnessNormalizationType | **string**<br>Specifies type of loudness normalization. Optional. Default: `LUFS`.<br><ul> <li>MAX_PEAK: The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.</li> <li>LUFS: The type of normalization based on EBU R 128 recommendation.</li> </ul> 
unsafeMode | **boolean** (boolean)<br><p>Optional. Automatically split long text to several utterances and bill accordingly. Some degradation in service quality is possible.</p> 
text | **string** <br> includes only one of the fields `text`, `textTemplate`<br><br><p>Raw text (e.g. "Hello, Alice").</p> 
textTemplate | **object**<br>Text template instance, e.g. `{"Hello, {username}" with username="Alice"}`. <br> includes only one of the fields `text`, `textTemplate`<br>
textTemplate.<br>textTemplate | **string** <br> includes only one of the fields `text`, `textTemplate`<br><br><p>Template text.</p> <p>Sample:``The {animal} goes to the {place}.``</p> 
textTemplate.<br>variables[] | **object**<br><p>Defining variables in template text.</p> <p>Sample: ``{animal: cat, place: forest}``</p> 
textTemplate.<br>variables[].<br>variableName | **string**<br><p>The name of the variable.</p> 
textTemplate.<br>variables[].<br>variableValue | **string**<br><p>The text of the variable.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "audioChunk": {
    "data": "string"
  },
  "textChunk": {
    "text": "string"
  },
  "startMs": "string",
  "lengthMs": "string"
}
```

 
Field | Description
--- | ---
audioChunk | **object**<br><p>Part of synthesized audio.</p> 
audioChunk.<br>data | **string** (byte)<br><p>Sequence of bytes of the synthesized audio in format specified in output_audio_spec.</p> 
textChunk | **object**<br><p>Part of synthesized text.</p> 
textChunk.<br>text | **string**<br><p>Synthesized text.</p> 
startMs | **string** (int64)<br><p>Start time of the audio chunk in milliseconds.</p> 
lengthMs | **string** (int64)<br><p>Length of the audio chunk in milliseconds.</p> 