using Shopfy.ShopfyDomain;
using Shopfy.Shopify.Repo;

namespace Shopfy.Shopify.Services
{
    public class CategoriesServices
    {
        private readonly CategoriesRepo _categoriesRepo;

        public CategoriesServices(CategoriesRepo categoriesRepo)
        {
            this._categoriesRepo = categoriesRepo;
        }

        public List<Categories> DisplayCategoriesServices()
        {
            var Categories = _categoriesRepo.displayCategories();
            return Categories;

        }
        public Categories InsertCategoriesService(Categories categories)
        {
            var categorie = _categoriesRepo.InsertCategoriesFunction(categories);

            return categories;
        }

    }
}
