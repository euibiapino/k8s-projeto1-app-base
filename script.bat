@echo off
chcp 65001 >nul
cls


echo.
echo ╔═══════════════════════════════════════════════╗
echo ║            🚀 DEPLOY RÁPIDO                   ║
echo ║      Aplicação PHP + MySQL + Frontend        ║
echo ╚═══════════════════════════════════════════════╝
echo.


echo [INFO] Verificando Docker...
docker --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERRO] Docker não encontrado! Instale o Docker Desktop primeiro.
    pause
    exit /b 1
)

docker info >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERRO] Docker não está rodando! Inicie o Docker Desktop primeiro.
    pause
    exit /b 1
)

echo [OK] Docker está funcionando!



echo [INFO] Verificando arquivos do projeto...
if not exist "docker-compose.yml" (
    echo [ERRO] docker-compose.yml não encontrado!
    pause
    exit /b 1
)

echo [OK] Arquivos verificados!


echo.
echo [INFO] Parando containers antigos...
docker-compose down >nul 2>&1



echo [INFO] Limpando containers antigos...
docker-compose rm -f >nul 2>&1



echo [INFO] Construindo e iniciando aplicação...
echo [AVISO] Primeira execução pode demorar alguns minutos...
echo.

docker-compose up --build -d

if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERRO] Falha no deploy! Executando com logs visíveis:
    echo.
    docker-compose up --build
    pause
    exit /b 1
)



echo.
echo [INFO] Aguardando MySQL ficar pronto...
timeout /t 10 >nul

:CHECK_MYSQL
docker exec mysql-container mysqladmin ping -h localhost -u root -pSenha123 >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [AGUARDANDO] MySQL ainda inicializando...
    timeout /t 5 >nul
    goto CHECK_MYSQL
)



echo.
echo ╔═══════════════════════════════════════════════╗
echo ║             ✅ DEPLOY CONCLUÍDO!              ║
echo ╚═══════════════════════════════════════════════╝
echo.
echo 🌐 Aplicação disponível em: http://localhost
echo ⚙️  Backend API em: http://localhost:8080
echo 🐘 MySQL em: localhost:3307
echo.
echo 📊 Status dos containers:
docker-compose ps
echo.



set /p abrir="Deseja abrir a aplicação no navegador? (s/n): "
if /i "%abrir%"=="s" (
    echo.
    echo [INFO] Abrindo navegador...
    start http://localhost
)

echo.
echo ╔═══════════════════════════════════════════════╗
echo ║              🎉 TUDO PRONTO!                  ║
echo ╚═══════════════════════════════════════════════╝
echo.
echo Comandos úteis:
echo   Para parar:     docker-compose down
echo   Para reiniciar: docker-compose restart
echo   Ver logs:       docker-compose logs
echo.
echo Pressione qualquer tecla para sair...
pause >nul