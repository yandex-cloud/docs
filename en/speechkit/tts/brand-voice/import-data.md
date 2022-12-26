# Importing data for {{ brand-voice-name }}

{{ brand-voice-name }} technology lets you create unique voices for a speech synthesis model. For model training and subsequent validation, audio recordings of the speaker's voice and transcriptions of recorded phrases are required. For details, see [{#T}](income-data-format.md).

The input data is validated using a [{{ ml-platform-full-name }}](../../../datasphere-old/) project.

1. [Create](../../../resource-manager/operations/folder/create.md) in your cloud the folder where you'll store data for model training. There can be only one model per folder.

1. In this folder, [create a project](../../../datasphere-old/operations/projects/create.md) {{ ml-platform-name }}.

1. Go to the **File Browser** ![File Browser](../../../_assets/datasphere/jupyterlab/folder.svg) tab.

1. Upload a ZIP archive containing audio files and a table in [TSV]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/TSV){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Tab-separated_values){% endif %} format containing the transcripts of the audio recordings by dragging the files to the **File Browser** ![File Browser](../../../_assets/datasphere/jupyterlab/folder.svg) tab.

   If you recorded the data over the course of several days, break it down into several archives. Name each archive to correspond to the date when the recording was made, such as `12.12.2021.zip`. If an archive containing the recordings made in a single day is larger than 2 GB, break the data and the transcript table into several pieces, keeping the date in the name of each archive, such as `12.12.2021-1.zip` and `12.12.2021-2.zip`

1. Create a new notebook. Wait until the archive and the table with the transcripts are uploaded to the project. Run the code in the notebook cell.

   ```bash
   #!nirvana
   upload_tts_audio --dataset-name <recording date> \
                    --audio-archive <archive name>.zip \
                    --texts <transcript filename>.tsv \
                    --report-path <name of file with error details>.tsv \
                    --summary-path <name of file with output>.txt \
                    --language ru
   ```

1. After a cell finishes running, the data validation result will be written to the files specified in the `--summary-path` and the `--report-path` parameters.
   * If the source data passes validation, the result file shows the number of successfully uploaded files and the proportion of errors (`Errors rate 0.0`).
   * If errors are found in the source data, the proportion of errors (`Errors rate`), the number of issues, and the number of records that successfully passed validation are shown in the result file. A detailed description of the identified issues is recorded in the error detail file. Correct the identified errors, re-upload the data and run the cell with the code again.

1. If you split the source data into several archives, give each file a unique name. For each data portion, you need to separately run a cell with the code. When you run the code again with the same parameters, the previous results are overwritten.

1. To validate the uploaded data, run a cell with the following code:

   ```bash
   #!nirvana
   tts_dataset_list --list-path <name of file with output>.json
   ```

1. To delete the data you do not need, run a cell with the following code:

   ```python
   #!nirvana
   delete_tts_audio --dataset-name <recording date>
   ```
