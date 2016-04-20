class Product
    @@products = []

    attr_reader :title, :price
    attr_accessor :stock

    def initialize(options={})
        @title = options[:title]
        @price = options[:price]
        @stock = options[:stock]

        if self.class.find_by_title(@title)
            raise DuplicateProductError, "'#{@title}' already exists"
        end

        @@products << self
    end

    def in_stock?
        @stock > 0
    end

    # Class methods

    def self.all
        @@products
    end

    def self.find_by_title(title)
        @@products.find { |product| product.title == title }
    end

    def self.in_stock
        @@products.find_all { |product| product.in_stock? }
    end
end
