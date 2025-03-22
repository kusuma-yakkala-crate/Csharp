namespace Shopfy.ShopfyDomain
{
    public class Payment
    {
        public int Id { get; set; }
     

        public int Amount { get; set; }

        public int status { get; set; }


        public int OrderId { get; set; }
        public virtual Orders Order { get; set; }
        public int CustomerId { get; set; }
        public virtual Customer Customer { get; set; }

    }
}
