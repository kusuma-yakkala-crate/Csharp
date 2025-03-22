using Shopfy.Shopify.Repo;
using Shopfy.ShopfyDomain;
namespace Shopfy.Shopify.Services;

    public class SubCategoriesServices
    {
        private readonly SubCategoriesRepo _SubCategoriesRepo;

        public SubCategoriesServices(SubCategoriesRepo subCategoriesRepo)
        {

            this._SubCategoriesRepo = subCategoriesRepo;
        }

        public List<SubCategories> displaySubCategoriesService()
        {

            var subCategories = _SubCategoriesRepo.displaySubCategories();
            return subCategories;
        }

        public SubCategories insertSubCategoriesService(SubCategories subCategories)
        {

            var subCategorie = _SubCategoriesRepo.InsertSubCategoriesFunction(subCategories);

            return subCategories;



        }

    

    }

