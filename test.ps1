# test.ps1
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Запуск автоматических тестов веб-приложения" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Переменные
$webAppPath = "D:\WebSites\MyApp"
$webUrl = "http://localhost:8080"

# Тест 1: Проверка существования index.html
Write-Host "`n[Тест 1] Проверка наличия index.html..." -ForegroundColor Yellow
if (Test-Path "$webAppPath\index.html") {
    Write-Host "[OK] index.html найден" -ForegroundColor Green
} else {
    Write-Host "[FAIL] index.html не найден" -ForegroundColor Red
    exit 1
}

# Тест 2: Проверка наличия тега h1
Write-Host "`n[Тест 2] Проверка структуры HTML..." -ForegroundColor Yellow
$content = Get-Content "$webAppPath\index.html" -Raw
if ($content -match "<h1>") {
    Write-Host "[OK] Тег H1 присутствует" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Тег H1 отсутствует" -ForegroundColor Red
    exit 1
}

# Тест 3: Проверка версии
Write-Host "`n[Тест 3] Проверка информации о версии..." -ForegroundColor Yellow
if ($content -match "Версия:") {
    Write-Host "[OK] Информация о версии присутствует" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Информация о версии отсутствует" -ForegroundColor Red
    exit 1
}

# Тест 4: Проверка доступности сайта
Write-Host "`n[Тест 4] Проверка доступности сайта..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri $webUrl -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "[OK] Сайт доступен (HTTP $($response.StatusCode))" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] Сайт вернул код $($response.StatusCode)" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "[FAIL] Сайт недоступен: $_" -ForegroundColor Red
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Все тесты пройдены успешно!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
exit 0
