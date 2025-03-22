using Shopfy.dTO;
using Shopfy.ShopfyDomain;
using Shopfy.Shopify.Repo;

namespace Shopfy.Shopify.Services
{
    public class CustomerService
    {
        private readonly CustomerRepo _customerRepo;

        public CustomerService(CustomerRepo customerRepo)
        {
            this._customerRepo = customerRepo;
        }


        public List<Customer> displayCustomerService()
        {
            var customer = _customerRepo.dispalyCustomer();
            return customer;
        }
        public CustomerDto InsertServiceFunction(CustomerDto CustomerDto)
        {
            var customers = _customerRepo.InsertCustomerFunction(CustomerDto);
            return CustomerDto;
        }

    }
}
