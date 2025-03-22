using Shopfy.dTO;
using Shopfy.ShopfyDomain;

namespace Shopfy.Shopify.Repo
{
    public class CustomerRepo
    {

        private shopifydbcontext context;

        public CustomerRepo(shopifydbcontext context)
        {

            this.context = context;
        }

        public List<Customer> dispalyCustomer()
        {
            var Customer = context.Customer.ToList();

            return Customer;
        }

        //public Customer InsertCustomerFunction(Customer customers)
        //{
        //    var customer = context.Customer.Add(customers);
        //    context.SaveChanges();
        //    return customers;

        //}
        public CustomerDto InsertCustomerFunction(CustomerDto customerDto)
        {
           
            var customerEntity = new Customer
            {
               
                Name = customerDto.Name,
                PhoneNumber = customerDto.PhoneNumber,
                Email = customerDto.Email,
                PasswordHash = customerDto.PasswordHash
            };

          
            context.Customer.Add(customerEntity);
            context.SaveChanges(); 

          
            customerDto.Id = customerEntity.Id; 

            return customerDto;  
        }


    }
}
