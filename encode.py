import sys

def txt_to_lp(archivo_txt, archivo_lp):
    try:
        # Leer el contenido del archivo y guardar cada línea en una lista
        with open(archivo_txt, "r", encoding="utf-8") as archivo_entrada:
            # Se elimina el salto de línea final de cada línea y se eliminan las líneas vacías
            lista_lineas = [linea.rstrip("\n") for linea in archivo_entrada if linea.strip()]
        
        # Escribir la lista en el archivo .lp
        with open(archivo_lp, "w", encoding="utf-8") as s:
            s.write(f"gridsize({str(len(lista_lineas))}).\n")
            for i in range(len(lista_lineas)):
                for j in range(len(lista_lineas[i])):
                    if lista_lineas[i][j] == "1":
                        s.write(f"_drawcircle({str(i)},{str(j)},black).\n")
                    elif lista_lineas[i][j] == "0":
                        s.write(f"_drawcircle({str(i)},{str(j)},white).\n")
        
    except FileNotFoundError:
        print(f"Error: El archivo '{archivo_txt}' no se encontró.")
    except Exception as e:
        print(f"Ocurrió un error inesperado: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Entrada incorrecta. Ejemplo:")
        print("   python encode.py dom02.txt dom02.lp")
    else:
        archivo_txt = sys.argv[1]
        archivo_lp = sys.argv[2]
        txt_to_lp(archivo_txt, archivo_lp)
