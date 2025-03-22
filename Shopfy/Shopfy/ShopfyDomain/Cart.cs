namespace Shopfy.ShopfyDomain
{
    public class Cart
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public virtual Customer Customer { get; set; }

    }
}
