using Shopfy.ShopfyDomain;
namespace Shopfy.Shopify.Repo
{
    public class SubCategoriesRepo
    {
        private shopifydbcontext context;
        public SubCategoriesRepo(shopifydbcontext context)
        {
            this.context = context;

        }
        public List<SubCategories> displaySubCategories()
        {
            var subCategories = context.SubCategories.ToList();
            return subCategories;
        }
        public SubCategories InsertSubCategoriesFunction(SubCategories subCategories)
        {
            var subCategorie = context.SubCategories.Add(subCategories);
            context.SaveChanges();
            return subCategories;
        }
    }
}
