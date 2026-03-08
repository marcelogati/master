namespace ProjetoGerenciamento.Model
{
    public class Transacao
    {
        public string  Descricao { get; set; }
        public decimal Valor { get; set; }
        public string  Tipo { get; set; }
        public int     Identificador_Categoria { get; set; }
        public int     Identificador_Pessoa { get; set; }
    }
}
