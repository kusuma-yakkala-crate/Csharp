namespace Shopfy.ShopfyDomain
{
    public class OrderItems
    {
        public int Id { get; set; }

        public int quantity { get; set; }

        public int price { get; set; }

        public int OrdersId { get; set; }
        public virtual Orders Orders { get; set; }

        public int ProductId { get; set; }
        public virtual Products Products { get; set; }


    }
}
