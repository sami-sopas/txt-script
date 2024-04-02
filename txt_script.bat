
@echo off
title Gestor de archivos de texto
cls

rem Mostrar mensaje de bienvenida
echo Bienvenido al Gestor de Archivos de Texto!

:menu
cls
echo Opciones:
echo 1. Abrir archivo
echo 2. Crear archivo
echo 3. Editar archivo
echo 4. Eliminar archivo
echo 5. Mostrar contenido
echo 6. Buscar texto
echo 7. Agregar texto al final
echo 8. Agregar texto al inicio
echo 9. Eliminar linea
echo 10. Copiar archivo
echo 11. Mover archivo
echo 12. Cambiar nombre
echo 13. Convertir a mayusculas
echo 14. Convertir a minusculas
echo 15. Salir
echo --------------------
set /p opcion="Ingrese el numero de la opcion que desea ejecutar: "

if "%opcion%"=="1" goto abrir
if "%opcion%"=="2" goto crear
if "%opcion%"=="3" goto editar
if "%opcion%"=="4" goto eliminar
if "%opcion%"=="5" goto mostrar
if "%opcion%"=="6" goto buscar
if "%opcion%"=="7" goto agregar_fin
if "%opcion%"=="8" goto agregar_inicio
if "%opcion%"=="9" goto eliminar_linea
if "%opcion%"=="10" goto copiar
if "%opcion%"=="11" goto mover
if "%opcion%"=="12" goto cambiar_nombre
if "%opcion%"=="13" goto mayusculas
if "%opcion%"=="14" goto minusculas
if "%opcion%"=="15" goto fin

:abrir
set /p archivo="Ingrese el nombre del archivo que desea abrir: "
start %archivo%
pause
goto menu

:crear
set /p archivo="Ingrese el nombre del archivo que desea crear: "
type nul > %archivo%
echo Archivo creado correctamente.
pause
goto menu

:editar
set /p archivo="Ingrese el nombre del archivo que desea editar: "
notepad %archivo%
pause
goto menu

:eliminar
set /p archivo="Ingrese el nombre del archivo que desea eliminar: "
del %archivo%
echo Archivo eliminado correctamente.
pause
goto menu

:mostrar
set /p archivo="Ingrese el nombre del archivo que desea mostrar: "
type %archivo%
pause
goto menu

:buscar
set /p archivo="Ingrese el nombre del archivo en el que desea buscar: "
set /p texto="Ingrese el texto que desea buscar: "
findstr /i /c:"%texto%" %archivo%
pause
goto menu

:agregar_fin
set /p archivo="Ingrese el nombre del archivo al que desea agregar texto: "
set /p texto="Ingrese el texto que desea agregar: "
echo %texto% >> %archivo%
echo Texto agregado correctamente.
pause
goto menu

:agregar_inicio
set /p archivo="Ingrese el nombre del archivo al que desea agregar texto al inicio: "
set /p texto="Ingrese el texto que desea agregar al inicio: "
(
  echo %texto%
  type %archivo%
) > %archivo%.tmp
move /y %archivo%.tmp %archivo%
echo Texto agregado al inicio correctamente.
pause
goto menu

:eliminar_linea
set /p archivo="Ingrese el nombre del archivo del que desea eliminar línea: "
set /p linea="Ingrese el número de línea que desea eliminar: "
(
  for /f "tokens=1* delims=:" %%a in ('findstr /n "^" %archivo%') do (
    if not "%%a"=="%linea%" (
      echo %%b
    )
  )
) > %archivo%.tmp
move /y %archivo%.tmp %archivo%
echo Línea eliminada correctamente.
pause
goto menu

:copiar
set /p origen="Ingrese el nombre del archivo que desea copiar: "
set /p destino="Ingrese el nombre del nuevo archivo: "
copy %origen% %destino%
echo Archivo copiado correctamente.
pause
goto menu

:mover
set /p origen="Ingrese el nombre del archivo que desea mover: "
set /p destino="Ingrese el nombre del directorio de destino: "
move %origen% %destino%
echo Archivo movido correctamente.
pause
goto menu

:cambiar_nombre
set /p archivo="Ingrese el nombre del archivo que desea renombrar: "
set /p nuevo_nombre="Ingrese el nuevo nombre del archivo: "
ren %archivo% %nuevo_nombre%
echo Archivo renombrado correctamente.
pause
goto menu

:mayusculas
set /p archivo="Ingrese el nombre del archivo que desea convertir a mayusculas: "
powershell -Command "(Get-Content %archivo%) | ForEach-Object { $_.ToUpper() } | Set-Content temp.txt"
move /y temp.txt %archivo%
echo Archivo convertido a mayúsculas correctamente.
pause
goto menu

:minusculas
set /p archivo="Ingrese el nombre del archivo que desea convertir a minusculas: "
powershell -Command "(Get-Content %archivo%) | ForEach-Object { $_.ToLower() } | Set-Content temp.txt"
move /y temp.txt %archivo%
echo Archivo convertido a minúsculas correctamente.
pause
goto menu


:fin
echo Saliendo...
exit
