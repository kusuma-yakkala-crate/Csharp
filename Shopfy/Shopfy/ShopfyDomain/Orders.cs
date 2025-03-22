//namespace Shopfy.ShopfyDomain
//{
//    public class Order
//    {
//        public int Id { get; set; }
//        public int CustomerId { get; set; }  // Add this
//        public int AddressId { get; set; }   // Add this
//        public virtual Customer Customer { get; set; }
//        public virtual Address Address { get; set; }
//    }
//}

namespace Shopfy.ShopfyDomain
{
    public class Orders
    {
        public int Id { get; set; }

	public decimal totalamount { get; set; }
	public string ordersstatus { get; set; }

        public DateTime orderedDate { get; set; }
        public int CustomerId { get; set; }
        public virtual Customer Customer { get; set; }

    }
}
