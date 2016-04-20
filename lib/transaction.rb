class Transaction
    @@id = 1
    @@transactions = []

    attr_reader :id, :customer, :product

    def initialize(customer, product, is_return = false)
        if !is_return && !product.in_stock?
            raise OutOfStockError, "'#{product.title}' is out of stock"
        end

        if !is_return && customer.cash < product.price
            raise OutOfCashError, "$#{customer.cash} not enough to purchase #{product.title} for $#{product.price}"
        end

        if is_return && !customer.has_product?(product)
            raise NoProductError, "#{customer.name} does not have a #{product.title} to return"
        end

        @id = @@id
        @customer = customer
        @product = product

        if is_return
            @product.stock += 1
            @customer.cash += @product.price
            @customer.products.delete_at(@customer.products.index(@product))
        else
            @product.stock -= 1
            @customer.cash -= @product.price
            @customer.products << @product
        end

        @@id += 1
        @@transactions << self
    end

    def self.all
        @@transactions
    end

    def self.find(id)
        @@transactions.find { |transaction| transaction.id == id }
    end
end
