namespace Shopfy.ShopfyDomain
{
    public class WishlistItem
    {
        public int Id { get; set; }
        public int WishlistId { get; set; }
        public virtual Wishlist Wishlist { get; set; }
        public int ProductId { get; set; }
        public virtual Products Products { get; set; }
    }
}
