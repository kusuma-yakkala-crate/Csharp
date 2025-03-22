using Shopfy.ShopfyDomain;

namespace Shopfy.Shopify.Repo
{
    public class CategoriesRepo
    {
        private shopifydbcontext context;
        public CategoriesRepo(shopifydbcontext context)
        {
            this.context = context;

        }
        public List<Categories> displayCategories()
        {
            var categories = context.Categories.ToList();
            return categories;
        }
        public Categories InsertCategoriesFunction(Categories categories)
        {
            var categorie = context.Categories.Add(categories);
            context.SaveChanges();
            return categories;
        }
    }
}
