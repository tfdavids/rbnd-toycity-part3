require_relative "transaction"

class Customer
    @@customers = []

    attr_reader :name, :products
    attr_accessor :cash

    def initialize(options={})
        @name = options[:name]
        @cash = options[:cash] || 100
        @products = []

        if self.class.find_by_name(@name)
            raise DuplicateCustomerError, "'#{@name}' already exists"
        end

        @@customers << self
    end

    def purchase(product)
        Transaction.new(self, product)
    end

    def return(product)
        Transaction.new(self, product, true)
    end

    def has_product?(product)
        @products.include?(product)
    end

    # Class methods

    def self.all
        @@customers
    end

    def self.find_by_name(name)
        @@customers.find { |customer| customer.name == name }
    end
end
