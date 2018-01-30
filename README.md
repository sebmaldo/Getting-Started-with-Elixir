# Notas del curso

Notas personales del curso Getting Started With Elixir, no pretende ser una explicación, es solo una anotación personal.

## Módulos

Los módulos definen separaciones conceptuales para agrupar funciones, se escriben como
```elixir
defmodule NombreDelModulo do
# Código acá
end
```

Dentro de los módulo van las definiciones de las funciones, para luego llamar a la función en el formato Modulo.funcion()
```elixir
defmodule NombreDelModulo do
    def NombreFuncion do
        # Código acá
    end
end
```

Al hacer una función como por ejemplo 
```elixir
defmodule ModulePlayground do
    def say_here do
        IO.puts "Here"
    end
end
```
Se recomienda que se hagan las importaciones en la parte superior.
```elixir
defmodule ModulePlayground do
    import IO
    def say_here do
        IO.puts "Here"
    end
end
```

Y mejor aún si se importa solo la función que se va a utilizar
```elixir
defmodule ModulePlayground do
    import IO, only: [puts: 1]
    def say_here do
        puts "I'm Here"
    end
end
```

Al momento de levantar un módulo, se carga el módulo Kernel, si hay alguna función con el mismo nombre se produce un error, por ejemplo.

```elixir
defmodule ModulePlayground do
    import IO, only: [puts: 1]
    
    def say_here do
        puts "I'm Here"
    end

    def inspect(param1) do
        puts "Starting Output"
        puts param1
        puts "Ending output"
    end
end
```
En el módulo Kernel ya existe una función inspect, por lo que se genera un error al cargar el módulo, hay una forma de cargar la función pese la duplicidad, excepcionando la función **inspect** de la carga del módulo Kernel, en ningún caso se recomienda hacer esto para el módulo Kernel, pero si es bueno saber usar la excepción de carga para módulos propios, abajo un ejemplo de como lograrlo. 

```elixir
defmodule ModulePlayground do
    import IO, only: [puts: 1]
    import Kernel, except: [inspect: 1]
    
    def say_here do
        puts "I'm Here"
    end

    def inspect(param1) do
        puts "Starting Output"
        puts param1
        puts "Ending output"
    end
end
```

Se puede definir un alias con el comando **alias** para evitar la colisión de nombres, un ejemplo.
```elixir
defmodule ModulePlayground do
    import IO, only: [puts: 1]
    import Kernel, except: [inspect: 1]

    alias ModulePlayground.Misc.Util.Math, as: MyMath

    def say_here do
        inspect "I'm Here"
    end

    def inspect(param1) do
        puts "Starting Output"
        puts param1
        puts "Ending output"
    end

    def print_sum do
        MyMath.add(1,2)
    end
end
```
Elixir tiene modulos y macros, en caso de necesitar utilizar una macro en una función de elixir, se debe usar la directiva require, en el ejemplo abajo se requiren todas las macros del modulo Integer.
```elixir
defmodule ModulePlayground do
    import IO, only: [puts: 1]
    import Kernel, except: [inspect: 1]

    alias ModulePlayground.Misc.Util.Math, as: MyMath
    require Integer

    def say_here do
        inspect "I'm Here"
    end

    def inspect(param1) do
        puts "Starting Output"
        puts param1
        puts "Ending output"
    end

    def print_sum do
        MyMath.add(1,2)
    end

    def print_is_even(num) do
        puts "Is #{num} even? #{Integer.is_even(num)}"
    end
end
```

### Resúmen
1. Import
    * Incluye módulos y funciones.
    * Incluye o excluye funciones específicas.
2. Alias
    * Reduce la cantidad de tipeo.
    * Puede renombrar módulos.
3. Require
    * Permite incluir macros en los módulos.

## Funciones
Si tomamos la función de abajo
```elixir
defmodule Sample.Enum do
    def first(list) do
        hd(list)
    end
end
```
Esta función en notación elixir sería **first/1**, primero se toma el nombre de la función y el segundo es la aridad **{nombre}/{aridad}**, además se puede notar que no es necesario retornar, siempre se retorna la última expresión evaluada, como en ruby.

Además se debe tomar en cuenta el manejo de patrones, en la función de abajo
```elixir
defmodule Sample.Enum do
    def first([]), do: nil
    def first([head | _ ]), do: head
end
```
Se define la función con el mismo nombre pero con un patrón diferente al recibir, la primera recibe una lista vacía y la segunda una lista con por lo menos un head. En lugar de un if, se recomienda usar los patrones de match.

### Guard Clauses
Una clausula es una especie de condición de cuando o no ejecutar una función, por ejemplo la función anterior, lograda con patrones, se pude hacer con clausulas de la siguiente manera
```elixir
defmodule Sample.Enum do
    def first(list) when length(list)=0 do: nil
    def first([head | _ ]), do: head
end
```
Después de la definición viene la palabra reservada when, que permite hacer una distinción de cuando ejecutar esa función, si no se puede ejecutar, sige con la siguiente función.

En una clausula se pueden usar
 - comparaciones (==, !=, ===, !==, >, >=, <, <=)
 - booleanos (and, or, not)
 - operadores aritmeticos (+, -, * /)
 - concatenaciones binarias <>
 - el operador **in** siempre y cuando el lado derecho sea un rango o una lista
 - chequeos de tipo
    - is_atom/1
    - is_binary/1
    - is_bitstring/1
    - is_boolean/1
    - is_float/1
    - is_function/1
    - is_function/2
    - is_integer/1
    - is_list/1
    - is_map/1
    - is_nil/1
    - is_number/1
    - is_pid/1
    - is_port/1
    - is_reference/1
    - is_tuple/1
- funciones adicionales
    - abs(number)
    - binary_path(binary, start, length)
    - bit_size(bitstring)
    - byte_size(bitstring)
    - div(integer, integer)
    - elem(tuple, n)
    - hd(list)
    - length(list)
    - map_size(map)
    - node()
    - node(pid | ref | port)
    - rem(integer, integer)
    - round(number)
    - self()
    - tl(list)
    - trunc(number)
    - tuple_size(tuple)
    