# Importing data to retrain a model

By retraining a model, you can teach it to recognize specific vocabulary. Retraining requires custom data, such as a glossary and text templates with variables. 

{% include [data-formats](../../_includes/speechkit/training-data-format.md) %}

For more information on input data format and amount, see [{#T}](additional-training.md#data).

Input data is imported using a {{ ml-platform-full-name }} project:

## Importing data {#how-to-upload}

1. [Create](../../resource-manager/operations/folder/create.md) a folder in your cloud to store your model training data. There can be only one model per folder.

1. In this folder, [create a project](../../datasphere-old/operations/projects/create.md) for {{ ml-platform-name }}.

1. Click a tab called **File Browser** ![File Browser](../../_assets/datasphere/jupyterlab/folder.svg).

1. Import a table in TSV format with templates into the project by dragging the file to the **File Browser** ![File Browser](../../_assets/datasphere/jupyterlab/folder.svg).

1. In the project tree, create a folder to store all the glossary files. Import the files into the created folder.

1. Create a new notebook. Wait for the data files to import into the project.

1. Insert and run a data validation function in one notebook cell, and call a function for your data in another. If the validation is successful, the function will generate an archive to import into {{ speechkit-name }}.

   {% cut "Data verification function code" %}

   ```python
   import re
   import tarfile
   from typing import Tuple, List
   from pathlib import Path
   from typing import Optional


   var_desc_regex = re.compile(r'{.+=.+}')
   var_text_regex = re.compile(r'[^a-ya-ya-]')
   template_text_regex = re.compile(r'[^a-ya-YA ,.!-]')
   punct_regex = re.compile(r'[.!]')


   def validate_template(template: str, variable_sources: List[str]) -> Tuple[bool, str]:
       variable_sources = set(variable_sources)
       for var in var_desc_regex.findall(template):
           var_name, source_path = var[1:-1].split('=')
           if not source_path.endswith('.tsv'):
              return False, f'Description of "{source_path}" variable has a non-TSV extension'
           if source_path not in variable_sources:
            return False, f'Description of "{source_path}" variable is not found'

       template = var_desc_regex.sub('', template).strip()
       if template and punct_regex.findall(template[:-1]):
           return False, f'The middle part of the template contains end-of-sentence punctuation marks'

       max_len = 120
       if len(template) > max_len:
           return False, f'The template length excluding variable inserts must not exceed {max_len} characters'

       errors = set(template_text_regex.findall(template))
       if errors:
           return False, f'The template contains invalid characters: {errors}'

       return True, ''


   def validate_variable(variable: str) -> Tuple[bool, str]:
       max_len = 40
       if len(variable) > max_len:
           return False, f'The variable length must not exceed {max_len} characters'

       errors = set(var_text_regex.findall(variable))
       if errors:
           return False, f'The variable contains invalid characters: {errors}'
       return True, ''


   def check_templates(templates_path: str, variables_path: Optional[str]):
       templates_path = Path(templates_path)
       if not templates_path.exists():
          raise ValueError(f'\nThe template file "{templates_path}" is not found')
       if not templates_path.name.endswith('.tsv'):
          raise ValueError(f'\nThe template description "{templates_path}" has a non-TSV extension')

       if variables_path:
           variables_path = Path(variables_path)
           if not variables_path.exists() or not variables_path.is_dir():
               raise ValueError(f'\nThe folder "{variables_path}" is not found')
           variable_sources = [f.name for f in variables_path.iterdir()]
       else:
           variable_sources = []

       for source in variable_sources:
           if not source.endswith('.tsv'):
               continue
           if not Path(variables_path, source).is_file():
               raise ValueError(f'\nThe description of the "{source}" variable is not found')
           for variable in Path(variables_path, source).read_text().splitlines():
               valid, msg = validate_variable(variable)
               if not valid:
                   raise ValueError(f'\nInvalid variable"{variable}"\n{msg}')

       for template in templates_path.read_text().splitlines():
           valid, msg = validate_template(template, variable_sources)
           if not valid:
               raise ValueError(f'\nInvalid template "{template}"\n{msg}')


   def prepare_stt_templates(templates_path: str, variables_path: Optional[str], output_path: str = 'templates.tar.gz'):
       check_templates(templates_path, variables_path)

       with tarfile.open(output_path, mode='w:gz') as tar:
           tar.add(templates_path, arcname='templates.tsv')
           if variables_path is not None:
               for source_path in Path(variables_path).iterdir():
                   if not source_path.name.endswith('.tsv'):
                       continue
                   tar.add(str(source_path), arcname=f'variables/{source_path.name}')

       print(f'The templates are successfully verified and placed into the archive {output_path}.\n'
             'Now you can upload this archive to DataSphere using the magic import_stt_templates macros')
   ```

   {% endcut %}

   Calling the data verification function:

   ```python
   prepare_stt_templates(templates_path='<name of file with templates>.tsv',
                         variables_path='<name of folder with glossaries>',
                         output_path='<name of file with results>.tar.gz')
   ```

1. Following successful validation and archiving, import the data into the model:

   ```bash
   #!nirvana
   import_stt_templates --templates-archive <name of archive with prepared data>.tar.gz \
                        --dataset-name <dataset name> \
                        --report-path <name of file with verification results>.txt
   ```
