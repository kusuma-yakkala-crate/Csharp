namespace Shopfy.ShopfyDomain
{
    public class Review
    {
        public int Id { get; set; }

       
        public float rating { get; set; }

        public int CustomerId { get; set; }
        public virtual Customer Customer { get; set; }
        public int ProductId { get; set; }
        public virtual Products Products { get; set; }


    }
}
