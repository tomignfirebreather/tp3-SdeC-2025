# TP3 - Modo Protegido (Sistemas de Computación)

Este repositorio contiene el tercer trabajo práctico de la asignatura **Sistemas de Computación** de la **FCEFyN - UNC**. El objetivo principal es comprender y experimentar con la transición del modo real al modo protegido en procesadores x86, explorando las capacidades avanzadas que este último ofrece.

## 📁 Estructura del Repositorio

- `00SimpleMBR/`: Implementación de un Master Boot Record (MBR) básico.
- `01HelloWorld/`: Ejemplo mínimo que muestra "Hello World" en modo real.
- `02QemuFiles/`: Archivos de configuración y scripts para emulación con QEMU.
- `03ProtectedMode/`: Código que realiza la transición al modo protegido.
- `04WritetoOnlyRead/`: Ejemplo que demuestra protección de escritura en segmentos de solo lectura.
- `img/`: Imágenes y capturas relacionadas con los ejemplos.
- `protected-mode-sdc/`: Submódulo con ejemplos adicionales de bare-metal en x86.

## 🛠️ Requisitos

- **QEMU**: Para emular el entorno de hardware.
- **NASM**: Ensamblador para lenguaje ensamblador x86.
- **Make**: Herramienta de automatización para la compilación.
- **Linux**: Se recomienda un entorno Linux para facilitar la ejecución y compatibilidad.

## 📑 Informe

El desarrollo del trabajo práctico se encuentra detallado en `docs/informe.pdf`