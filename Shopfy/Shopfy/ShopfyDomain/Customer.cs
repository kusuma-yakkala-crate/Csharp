//namespace Shopfy.ShopfyDomain
//{
//    public class Customer
//    {
//        public int Id { get; set; }

//        public string Name { get; set; }

//       public int PhoneNumber { get; set; }

//        public string Email { get; set; }
//    }
//}




namespace Shopfy.ShopfyDomain
{
    public class Customer
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string PhoneNumber { get; set; } 
        public string Email { get; set; }

        public virtual ICollection<Address> Addresses { get; set; }
        public virtual ICollection<Orders> Orders { get; set; }
    }
}
