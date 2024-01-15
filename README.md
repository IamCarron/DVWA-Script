# Instalación de DVWA en Kali Linux

Este script automatiza la instalación de Damn Vulnerable Web Application (DVWA) en Kali Linux, configurando el entorno web, la base de datos MySQL y la aplicación DVWA.

## Requisitos

- Kali Linux (o distribución basada en Debian)
- Conexión a Internet

## Uso

1. Descarga el script de instalación:

   ```bash
   wget https://raw.githubusercontent.com/IamCarron/DVWA-Script/main/Install-DVWA.sh
   ```

2. Otorga permisos de ejecución al script:

   ```
   chmod +x Install-DVWA.sh
   ```

3. Ejecuta el script con privilegios de superusuario:

   ```
   sudo ./Install-DVWA.sh
   ```

4. Sigue las instrucciones proporcionadas por el script.

## Notas

- Asegúrate de tener privilegios de superusuario para ejecutar el script.
- Si experimentas problemas durante la instalación, revisa los logs de MySQL y Apache para obtener información adicional.

Asegúrate de ajustar la URL de descarga, las instrucciones y otros detalles según sea necesario. Además, si hay alguna dependencia o requisito adicional que los usuarios deben tener antes de ejecutar el script.
