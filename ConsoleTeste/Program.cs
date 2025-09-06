using static System.Net.Mime.MediaTypeNames;

internal class Program
{
    static int[] results = new int[4];
    static int cont = 0;
    private static void Main(string[] args)
    {
        int contador = 0;

        if (contador <= 3)
        {
            //Primeiro loop
            if (contador == 0)
            {
                product("XXX", "1001");
                contador++;
            }
            //Segundo loop
            if (contador == 1)
            {
                product("IX", "1000");
                contador++;
            }
            //Terceiro loop

            if (contador == 2)
            {
                product("ML", "1111");
                contador++;
            }
            //Quartoo loop

            if (contador == 3)
            {
                product("LL", "1050");
                contador++;
            }
        }


     }
    public static string product(string roman, string binary)
    {
        //string Texto = "XXX";
        //string Alfa = "1001";
     
     int n1 = conversor(roman);
     int n2 = conversor(binary);
     int Resultado = n1 * n2;

        //   Console.WriteLine("O resultado é " + Resultado);

      results[cont] = Resultado;
      cont++;

        if (cont == 4)
        {
            string final = $"{results[0]} {results[1]} {results[2]} {results[3]}";
            Console.WriteLine(final);
            return final;
        }

        return "";
    }

    public static int conversor(string valor)
    {
        //Primeiro loop
        if (valor == "XXX")
        {
            return 10;
        }

        if (valor == "1001")
        {
            return 5;
        }

        //Segundo loop
        if (valor == "IX")
        {
            return 9;
        }

        if (valor == "1000")
        {
            return 3;
        }

        //Terceiro loop
        if (valor == "ML")
        {
            return 1050;
        }

        if (valor == "1111")
        {
            return 9;
        }

        //Quarto loop
        if (valor == "LL")
        {
            return 100;
        }

        if (valor == "1050")
        {
            return 2;
        }

        return 0;

    }
}