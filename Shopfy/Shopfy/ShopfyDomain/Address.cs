//namespace Shopfy.ShopfyDomain
//{
//    public class Address
//    {
//        public int Id { get; set; }

//        public string city { get; set; }
//        public string state { get; set; }
//        public string country { get; set; }
//        public string postalCode { get; set; }

//        public int CustomerId { get; set; }
//        public virtual Customer Customer { get; set; }

//    }
//}




namespace Shopfy.ShopfyDomain
{
    public class Address
    {
        public int Id { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Country { get; set; }
        public string PostalCode { get; set; }


        public int CustomerId { get; set; }
        public virtual Customer Customer { get; set; }



    }
}