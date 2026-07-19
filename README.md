# Encuesta de Satisfacción - Hesperia Playa el Agua

Aplicación web de encuesta de satisfacción hotelera con panel de administración.

## Funcionalidades

- **Encuesta wizard** con 7 secciones (Recepción, Habitación, Desayuno, Restaurante, Bar, Zonas Públicas, Animación)
- **Calificaciones** del 1 al 5 con escala bilingüe (español/inglés)
- **Panel de gestión** protegido con PIN (2026)
- **Dashboard** con KPIs, gráficos y estadísticas
- **Análisis** con ranking de departamentos, correlaciones, tendencias y recomendaciones
- **Exportación** a Excel y JSON
- **Importación** de archivos Excel/JSON
- **Sincronización** con Google Sheets vía Apps Script
- **Diseño responsive** optimizado para móvil

## Deploy en GitHub Pages

1. Crear un repositorio en GitHub
2. Subir el archivo `encuesta_satisfaccion_hesperia.html` como `index.html`
3. Ir a Settings > Pages
4. En "Source" seleccionar la rama `main` y la carpeta `/ (root)`
5. Guardar - la app estará disponible en `https://tu-usuario.github.io/tu-repositorio/`

## Uso

1. Abrir la app en el navegador
2. Completar la encuesta con los datos del huésped
3. Calificar cada área del hotel (1-5)
4. Enviar la encuesta
5. Acceder al panel de gestión con PIN: **2026**

## Almacenamiento

Las respuestas se guardan en `localStorage` del navegador. Para respaldos:
- Exportar a Excel o JSON desde el panel de datos
- Conectar con Google Sheets para sincronización automática

## Tecnologías

- HTML5, CSS3, JavaScript vanilla
- Chart.js para gráficos
- SheetJS (xlsx) para exportación Excel
- Google Fonts (Fraunces, Inter, IBM Plex Mono)
