class Transaction
    @@id = 1
    @@transactions = []

    attr_reader :id, :customer, :product

    def initialize(customer, product)
        if !product.in_stock?
            raise OutOfStockError, "'#{product.title}' is out of stock"
        end

        if customer.cash < product.price
            raise OutOfCashError, "$#{customer.cash} not enough to purchase #{product.title} for $#{product.price}"
        end

        @id = @@id
        @customer = customer
        @product = product

        @product.stock -= 1
        @customer.cash -= @product.price
        @customer.products << @product

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
