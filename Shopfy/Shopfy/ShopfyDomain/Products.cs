using System.Reflection.Metadata;
using System.Text.Json.Serialization;

namespace Shopfy.ShopfyDomain
{
    public class Products
    {
        public int Id { get; set; }
        public string productName { get; set; }
        public string ProductTittle { get; set; }
        public string Image { get; set; }
        public float star { get; set; }
        public decimal NewPrice { get; set; }
        public decimal oldprice { get; set; }
        public string brand { get; set; }
        public int  stock{ get; set; }

        public string discription { get; set; }
        public string Reviewdiscription { get; set; }

        public int SalesCount { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public int SubCategoriesId { get; set; }

      
        public virtual SubCategories SubCategories { get; set; }

        public string SubCategoriesName { get; set; }



    }
}
