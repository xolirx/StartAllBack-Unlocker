# 🚀 XOLIRX - StartAllBack Unlocker

Активация StartAllBack одной командой

---

## 📖 ИНСТРУКЦИЯ ПО АКТИВАЦИИ

### Шаг 1. Откройте PowerShell

Нажмите `Win + R`, введите `powershell`, нажмите `Enter`

### Шаг 2. Перейдите в папку с файлом

```powershell
cd C:\Users\user\Desktop\xolirx
```

*(Замените путь на ваш, где лежит `xolirx.ps1`)*

### Шаг 3. Запустите активацию

```powershell
Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$PWD\xolirx.ps1`""
```

### Шаг 4. Подтвердите

Нажмите **"Да"** во всплывающем окне

### Шаг 5. Готово!

Активация выполнена ✅

---

## 🔄 ВОССТАНОВЛЕНИЕ

Если нужно вернуть оригинал:

```powershell
Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$PWD\xolirx.ps1`" -Restore"
```

---

## ⚡ БЫСТРЫЙ ЗАПУСК (одной строкой)

```powershell
cd C:\Users\user\Desktop\xolirx; Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$PWD\xolirx.ps1`""
```

---

## 📁 ФАЙЛЫ

| Файл | Описание |
|------|----------|
| `xolirx.ps1` | Основной скрипт активации |

---

## ⚠️ ТРЕБОВАНИЯ

- Windows 10 / 11 (x64)
- Установленный StartAllBack
- Права администратора

---

## ⭐ Поддержите проект

Поставьте звезду на GitHub, если помогло!

---

**XOLIRX** | Только для образовательных целей
```
