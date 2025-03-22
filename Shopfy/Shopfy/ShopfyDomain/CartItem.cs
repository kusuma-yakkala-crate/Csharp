namespace Shopfy.ShopfyDomain
{
    public class CartItem
    {
        public int Id { get; set; }

        public int total { get; set; }

        public int quantity {  get; set; }

        public int ProductId { get; set; }
        public virtual Products Products { get; set; }


        public int CartId { get; set; }
        public virtual Cart Cart { get; set; }


    }
}
