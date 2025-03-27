# Puzzle Yin Yang

**Guilllermo Blanco Núñez & Fiz Garrido Escudero**

---

## Reglas

El problema consiste de dos reglas claras:

1. **Conectividad:**  
   Todas las celdas deben estar otrogonalmente conectadas en un solo grupo al resto de celdas de su mismo color.

2. **Distribución en bloques 2x2:**  
   En un espacio de 2x2 celdas, no pueden ser las cuatro celdas del mismo color.

A partir de estas dos reglas se pueden deducir otros dos lemas que, de manera implícita, ayudan a reducir significativamente el tiempo de ejecución del programa.

### Lemas

- **Lema 1:**  
  Considerando solo las celdas del borde del tablero, todas deben estar otrogonalmente conectadas en un solo grupo al resto de celdas de su mismo color.

- **Lema 2:**  
  En un espacio 2x2 celdas, no pueden ser cada diagonal de un color distinto (ni ambas del mismo, obviamente por la regla 2).

---

## Instrucciones de ejecución

1. **Preparar el fichero inicial:**  
   Añadir a la carpeta `examples` un fichero `.txt` que contenga el estado inicial:
   
   - `0` marca una celda blanca.
   - `1` marca una celda negra.
   - `.` marca una celda por rellenar.
   
   El fichero se llamará `domXX.txt`, siendo `XX` el número asignado a ese dominio. En esta carpeta ya existen algunos ejemplos de ficheros `domXX.txt` que se pueden utilizar.

2. **Generar el fichero LP:**  
   Ejecutar en la CMD, dentro de la carpeta del repositorio, el siguiente comando:
   
   ```bash
   python encode.py examples\domXX.txt examples\domXX.lp
    ```
    Siendo `domXX.txt` el fichero creado en el paso 1 y `domXX.lp` un fichero del mismo nombre tipo .lp que se creará en la ejecución.

3. **Generar la solución gráficamente:** 

    Ejecutar en la CMD dentro de la carpeta del repositorio el siguiente comando:
            
    ```bash 
    python display.py yinyangKB.lp examples\domXX.lp drawyinyang.lp
    ```
    Siendo `domXX.lp` el nombre del fichero creado con la ejecución del paso 2.
    Por pantalla se mostrará la solución al puzzle YinYang planteado en el fichero inicial `domXX.txt`.