# Marking up audio files

Audio markup is a special way to transcribe audio recordings provided by Yandex as part of the {{ speechkit-pro-name }} solution. The results of transcribing audio files are presented in text form. Audio markup is not performed by a machine learning algorithm, it's performed by humans according to certain rules. This approach lets you transcribe data that conventional algorithms have difficulty with: poor-quality audio recordings that contain background noise, unintelligible speech, or words that can only be understood in context.

For markup, the source dataset is divided into small fragments so that each part of audio is present in multiple fragments. This increases the accuracy of the transcription.

In this use case, the transfer of audio recordings for markup is shown based on prepared files. To pass audio recordings for mark up:

1. [Upload files to mark up](#files-uploading).
1. [Get the markup results](#results).

## Rules for transcribing audio recordings {#rules}

When transcribing audio recordings using this method, the following rules apply:

* Both words and interjections (<q>aha</q>, <q>uh-huh</q>, and so on) are transcribed.

* Numbers are written as words (<q>fifth</q> and <q>five</q> are not converted to <q>5</q>).

* Spelling must be accurate (misspelt words, such as <q>necessery</q> instead of <q>necessary</q>, and incorrect homophones, such as <q>red</q> instead of <q>read</q>, are not acceptable).

* Foreign words are transliterated phonetically (<q>sputnik</q>, <q>babushka</q>, <q>lapta</q>).

* Slang is written as closely to its pronunciation as possible (<q>gotcha</q>).

    If the exact form of a word is not clearly heard on the recording, it's not written as a slang word (in this case <q>gotcha</q> is converted to <q>got you</q>).

* Abbreviations, formulas, and unknown words are written as they are heard (<q>H<sub>2</sub>O</q> → <q>aitch  two oh</q>, <q>SOS</q> → <q>es oh es</q>, and so on).

* Special characters are written as words (<q>*#06#</q> → <q>asterisk hash zero six hash</q>).

* Unintelligible words are replaced with the symbol `?`.

## Working with personal data {#sencetive-data}

Despite the fact that audio recordings are processed by people, the audio markup technology lets you maintain the confidentiality of data during transcription. Personal data is protected as follows:

* The fragment size is chosen to be small enough.

    This is done to minimize the possibility of including personal data, but at the same ensures the utterance makes sense.

* The voice on the recording is changed beyond recognition.

* Transcribed fragments are automatically merged into text corresponding to the original recording.

## Before you begin {#before-you-begin}

1. [Create a project](../datasphere-old/operations/projects/create.md) in **{{ ml-platform-name }}** and open it.

1. [Clone](../datasphere-old/operations/projects/work-with-git.md#clone) the Git repository that contains the notebooks with {{ yandex-cloud }} API usage examples:

    ```text
    https://github.com/yandex-cloud/examples
    ```

    Wait until cloning is complete. It may take some time. Once the operation is complete, the folder of the cloned repository will appear in the **File Browser** section.

1. Go to the `/examples/speechkitpro/markup/` folder and open the `markup.ipynb` notebook.

## Upload files to mark up {#files-uploading}

1. Review the test audio files in the `/examples/speechkitpro/markup/records/` folder.

    You can also upload your own audio files to this folder. File requirements:
    * **File format**: `MP3` or `WAV`.
    * **Sample rate**: `8000`, `16000`, or `48000` Hz.
    * **Bit depth**: 16 bit, little endian.

1. Select the notebook cell with the command to transfer files for markup by clicking to the left of it:

    ```bash
    #!nirvana
    sk_markup_records --records-dir ./examples/speechkitpro/markup/records/ --markup-result ./examples/speechkitpro/markup/results.json
    ```

1. Run this cell. To do this, choose **Run → Run Selected Cells** or press **Shift** + **Enter**.

    {% include [safe-state](../_includes/datasphere/safe-state.md) %}

1. Wait for the operation to complete:

    ```text
    [Step 1/2] Processing audio files from ./examples/speechkitpro/markup/records ...
    Collected 191 files of total size 7.76 MiB.
    Preparing collected data ...
    
    100.0% [==================================================>]
    
    Successfully prepared 191 audio files.
    Expected cost: 60 units
    
    Are you sure you want to continue? [yes/no]
    ```

    It outputs information about the number of files, their total size, and the approximate cost of recognition. For more information, see [{#T}](../speechkit/pricing.md).

1. Confirm sending the audio files for markup.

    In the input field, under the question **Are you sure you want to continue? [yes/no]**, type `yes` and press **Enter**.

    This starts the markup process:

    ```text
    Preceeding to next step.
    Running markup process for records in audio...
    ```

    It may take a long time. You can close the notebook and return to it later to check the status of the markup process.

## Get the markup results {#results}

As a result of the markup process, a file named `results.json` is created in the `/examples/speechkitpro/markup/` folder. The file contains a list of JSON objects in the following format:

```json
{
    "path": "<path to file N>",
    "text": "<human-marked up file N text>"
}
```

## Markup specifics {#features}

* The speed of markup depends on the quality and complexity of audio files and on a person's workload. At night, they mark up audio files slower.
* The markup speed is non-linear: marking up a complex, low-quality 30-minute audio recording may take the same time as marking up a high-quality 1-hour audio recording.
* It's recommended to upload audio recordings in chunks of no more than 10 hours.

