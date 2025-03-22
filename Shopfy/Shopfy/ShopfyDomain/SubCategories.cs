namespace Shopfy.ShopfyDomain
{
    public class SubCategories
    {
        public int SubCategoriesId  { get;set;}
        public string SubCategoriesName { get; set; }
        public virtual int CategoriesId { get; set; }

        public virtual Categories Categories { get; set; }





    }
}
