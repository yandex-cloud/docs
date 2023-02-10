# Импорт данных для дообучения модели

С помощью дообучения модель можно научить распознавать специфичную лексику. Для дообучения необходимы специально подготовленные данные — глоссарий и текстовые шаблоны с переменными. 

{% include [data-formats](../../_includes/speechkit/training-data-format.md) %}

Подробнее о формате и объеме входных данных см. [{#T}](additional-training.md#data).

Загрузка входных данных выполняется с помощью проекта {{ ml-platform-full-name }}:

## Как загрузить данные {#how-to-upload}

1. [Создайте](../../resource-manager/operations/folder/create.md) в своем облаке каталог, в котором вы будете хранить данные для обучения модели. В одном каталоге может быть только одна модель. 

1. В этом каталоге [создайте проект](../../datasphere-old/operations/projects/create.md) {{ ml-platform-name }}.

1. Перейдите на вкладку **File Browser** ![File Browser](../../_assets/datasphere/jupyterlab/folder.svg).

1. Загрузите в проект таблицу в формате TSV с шаблонами, перетащив файл на вкладку **File Browser** ![File Browser](../../_assets/datasphere/jupyterlab/folder.svg).

1. В структуре проекта создайте папку, в которой будут храниться все файлы с глоссариями. Загрузите файлы в созданную папку.

1. Создайте новый ноутбук. Дождитесь загрузки файлов с данными в проект.

1. В ячейку ноутбука добавьте код функции проверки данных, и вызовите ее для ваших данных. Если проверка пройдет успешно, функция сформирует архив для загрузки в {{ speechkit-name }}.

   {% cut "Код функции проверки данных" %}

   ```python
   import re
   import tarfile
   from typing import Tuple, List
   from pathlib import Path
   from typing import Optional


   var_desc_regex = re.compile(r'\{.+?=.+?\}')
   var_text_regex = re.compile(r'[^а-яёА-ЯЁ -]')
   template_text_regex = re.compile(r'[^а-яёА-ЯЁ ,:.?!-]')
   punct_regex = re.compile(r'[.?!]')


   def validate_template(template: str, variable_sources: List[str]) -> Tuple[bool, str]:
       variable_sources = set(variable_sources)
       for var in var_desc_regex.findall(template):
           var_name, source_path = var[1:-1].split('=')
           if not source_path.endswith('.tsv'):
              return False, f'Описание переменной "{source_path}" имеет расширение, отличное от TSV'
           if source_path not in variable_sources:
            return False, f'Описание переменной "{source_path}" не было найдено'

       template = var_desc_regex.sub('', template).strip()    
       if template and punct_regex.findall(template[:-1]):
           return False, f'В середине шаблона присутствуют знаки конца предложения'

       max_len = 120
       if len(template) > max_len:
           return False, f'Длина шаблона без учёта вставок переменных не должна превышать {max_len} символов'

       errors = set(template_text_regex.findall(template))
       if errors:
           return False, f'Шаблон содержит недопустимые символы: {errors}'

       return True, ''


   def validate_variable(variable: str) -> Tuple[bool, str]:
       max_len = 40
       if len(variable) > max_len:
           return False, f'Длина переменной не должна превышать {max_len} символов'

       errors = set(var_text_regex.findall(variable))
       if errors:
           return False, f'Переменная содержит недопустимые символы: {errors}'
       return True, ''


   def check_templates(templates_path: str, variables_path: Optional[str]):
       templates_path = Path(templates_path)
       if not templates_path.exists():
          raise ValueError(f'\nФайл с шаблонами "{templates_path}" не найден')
       if not templates_path.name.endswith('.tsv'):
          raise ValueError(f'\nОписание шаблонов "{templates_path}" имеет расширение, отличное от TSV')

       if variables_path:
           variables_path = Path(variables_path)
           if not variables_path.exists() or not variables_path.is_dir():
               raise ValueError(f'\nДиректория "{variables_path}" не найдена')
           variable_sources = [f.name for f in variables_path.iterdir()]
       else:
           variable_sources = []

       for source in variable_sources:
           if not source.endswith('.tsv'):
               continue
           if not Path(variables_path, source).is_file():
               raise ValueError(f'\nОписание переменной "{source}" не найдено')
           for variable in Path(variables_path, source).read_text().splitlines():
               valid, msg = validate_variable(variable)
               if not valid:
                   raise ValueError(f'\nНекорректная переменная "{variable}"\n{msg}')

       for template in templates_path.read_text().splitlines():
           valid, msg = validate_template(template, variable_sources)
           if not valid:
               raise ValueError(f'\nНекорректный шаблон "{template}"\n{msg}')


   def prepare_stt_templates(templates_path: str, variables_path: Optional[str], output_path: str = 'templates.tar.gz'):
       check_templates(templates_path, variables_path)

       with tarfile.open(output_path, mode='w:gz') as tar:
           tar.add(templates_path, arcname='templates.tsv')
           if variables_path is not None:
               for source_path in Path(variables_path).iterdir():
                   if not source_path.name.endswith('.tsv'):
                       continue
                   tar.add(str(source_path), arcname=f'variables/{source_path.name}')

       print(f'Шаблоны успешно проверены и помещены в архив {output_path}.\n'
             'Теперь вы можете загрузить этот архив в DataSphere, используя magic import_stt_templates')
   ```

   {% endcut %}

   Вызов функции проверки данных:

   ```python
   prepare_stt_templates(templates_path='<имя файла с шаблонами>.tsv',
                         variables_path='<имя папки с глоссариями>',
                         output_path='<имя файла с результатами>.tar.gz')
   ```

1. После успешной проверки и создания архива загрузите данные в модель:

   ```bash
   #!nirvana
   import_stt_templates --templates-archive <имя архива с подготовленными данными>.tar.gz \
                        --dataset-name <название датасета> \
                        --report-path <имя файла с результатами проверки>.txt
   ```
