namespace Shopfy.ShopfyDomain
{
    public class Wishlist
    {
        public int Id { get; set; }
        public string WishlistName { get; set; }
        public int CustomerId { get; set; }
        public virtual Customer Customer { get; set; }
   
    }
}
