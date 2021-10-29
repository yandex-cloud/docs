# Importing data for {{ brand-voice-name }}

{{ brand-voice-name }} technology lets you create unique voices for a speech synthesis model. For model training and subsequent validation, audio recordings of the speaker's voice and transcriptions of recorded phrases are required. For more information about the input data format, see [{#T}](income-data-format.md).

The input data is validated using the [{{ ml-platform-full-name }}](../../../datasphere/) project:

1. [Create](../../../resource-manager/operations/folder/create.md) in your cloud the folder where you'll store data for model training. There can be only one model per folder.

1. In this folder, [create a project](../../../datasphere/operations/projects/create.md) in {{ ml-platform-name }}.

1. Go to the tab **File Browser** ![File Browser](../../../_assets/datasphere/jupyterlab/folder.svg).

1. Upload a ZIP archive with audio files and a [TSV]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/TSV){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Tab-separated_values){% endif %} table with text transcripts of audio recordings to the project by dragging the files to the tab **File Browser** ![File Browser](../../../_assets/datasphere/jupyterlab/folder.svg).

   {% note info %}

   If the archive with audio recordings is more than 350 MB, we recommend splitting the data into several parts. In this case, the table with the transcripts should also be split into corresponding parts. Each file must have a unique name.

   {% endnote %}

1. Create a new notebook. Wait until the archive and the table with the transcripts are uploaded to the project. Run the code in the notebook cell.

   ```bash
   #!nirvana
   upload_tts_audio --dataset-name <project name> \
                    --audio-archive <archive name>.zip \
                    --texts <name of file with texts>.tsv \ 
                    --report-path <name of file with error details>.tsv \ 
                    --summary-path <name of file with results>.txt \
                    --language ru
   ```

1. After the cell is executed, the data validation result is written to the files specified in the `--summary-path` and `--report-path` parameters.
   * If the source data passes validation, the result file shows the number of successfully uploaded files and the proportion of errors (`Errors rate 0.0`).
   * If errors are found in the source data, the proportion of errors (`Errors rate`), the number of issues, and the number of records that successfully passed validation are shown in the result file. A detailed description of the identified issues is recorded in the error detail file. Correct the identified errors, re-upload the data and run the cell with the code again.

1. If you split the source data into several archives, give each file a unique name. For each data portion, you need to separately run a cell with the code. When you run the code again with the same parameters, the previous results are overwritten.

