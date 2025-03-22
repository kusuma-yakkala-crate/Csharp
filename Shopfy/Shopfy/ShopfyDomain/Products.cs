using System.Reflection.Metadata;
using System.Text.Json.Serialization;

namespace Shopfy.ShopfyDomain
{
    public class Products
    {
        public int Id { get; set; }
        public string productName { get; set; }
        public string Image { get; set; }
        public float star { get; set; }
        public decimal NewPrice { get; set; }

        public decimal oldprice { get; set; }
        public string brand { get; set; }
        public int  stock{ get; set; }

        public string discription { get; set; }

        public int SubCategoriesId { get; set; }

   
        public virtual SubCategories SubCategories { get; set; } 


    }
}
