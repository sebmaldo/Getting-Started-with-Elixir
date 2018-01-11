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