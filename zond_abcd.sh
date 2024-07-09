#!/bin/bash

# Описание: Формирование зондов
# Автор: Илья Филимонов (c) 2021
# Email: admin.cks@sevmeteo.ru, filimonov@arh.mecom.ru

# Переменные
date_str=$(date "+%d%m%y")
path1="/home/meteo/data/printed/$date_str"
path="/home/meteo/zond"
zond="$path/zond_R"

# Переход в рабочую директорию
cd "$path1"

# Определение функции для объединения файлов на основе шаблона
concat_files() {
    local pattern="$1"
    local output="$2"
    grep --null -l -i "$pattern" * | xargs -0 cat > "$output"
}

# Обработка и объединение файлов
concat_files "USRS13 RUMS" "$path/zond_A"
concat_files "UKRS13 RUMS" "$path/zond_B"
cat "$path/zond_B" >> "$path/zond_A"
concat_files "USRA15 RUAA" "$path/zond_C"
concat_files "UKRA15 RUAA" "$path/zond_D"
cat "$path/zond_D" >> "$path/zond_C"
cat "$path/zond_C" >> "$path/zond_A"
concat_files "USRA16 RUNW" "$path/zond_E"
concat_files "UKRA16 RUNW" "$path/zond_F"
cat "$path/zond_F" >> "$path/zond_E"
cat "$path/zond_E" >> "$path/zond_A"
concat_files "ULRS13 RUMS" "$path/zond_G"
concat_files "UERS13 RUMS" "$path/zond_H"
cat "$path/zond_H" >> "$path/zond_G"
concat_files "ULRA15 RUAA" "$path/zond_I"
concat_files "UERA15 RUAA" "$path/zond_K"
cat "$path/zond_K" >> "$path/zond_I"
cat "$path/zond_I" >> "$path/zond_G"
concat_files "ULRA16 RUNW" "$path/zond_L"
concat_files "UERA16 RUNW" "$path/zond_M"
cat "$path/zond_M" >> "$path/zond_L"
cat "$path/zond_L" >> "$path/zond_G"
cat "$path/zond_G" >> "$path/zond_A"

# Обработка итогового файла
cd "$path"
tr -d "[\001\003\015]" < zond_A > zond_N
grep -v '[*U]' zond_N > zond_O
grep '[A-Z0-9^0-9]' zond_O > zond_P
grep -v '^...$' zond_P > zond_R

# Удаление ненужных строк
sed -i '/NNNNZCZC/ d' "$zond"
sed -i '/ZCZC/ d' "$zond"
sed -i '/NNNN/ d' "$zond"

# Отправка и копирование результата
#mail -s "$(date +%d%m)" aero@arh.mecom.ru < "$zond"
#mail -s "$(date +%d%m)" sbor@arh.mecom.ru < "$zond"
cp "$zond" "/usr/meteo/aero/$(date +%d)"

# Очистка временных файлов
rm -rf "$path/zond_*"
