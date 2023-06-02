#!/usr/bin/ruby
class ShoppingBasket
  def run
    products = []
    totalTax = 0
    total = 0
    while true do
      import_tax = 0
      basic_tax = 0

      product = get_product

      original_value = get_original_value(product)
      product.sub! " at #{original_value}", ""
      
      quantity = get_quantity(product)

      product_value = original_value.to_f.round(2)

      is_imported = is_imported?(product)

      import_tax = calc_import_tax(original_value) if is_imported

      is_exempt = is_exempt?(product)

      basic_tax = calc_basic_tax(original_value) unless is_exempt
      
      totalTax += ((import_tax + basic_tax) * quantity).round(2)

      product_value = ((product_value + basic_tax + import_tax) * quantity).to_f.round(2)
      total += product_value
      
      products.push({:name => product, :value => product_value})

      break if add_another_product? == "N"
    end

    products.each do |product|
      puts "#{product[:name]}: #{product[:value]}"
    end
    puts "Sales Taxes: #{totalTax}"
    puts "Total: #{total.round(2)}"
  end
  
  def is_imported?(product)
    product.upcase.include?("IMPORTED")
  end

  def is_exempt?(product)
    product.upcase.include?("BOOK") || product.upcase.include?("CHOCOLATE") || product.upcase.include?("PILLS")
  end

  def calc_basic_tax(original_value)
    ((original_value.to_f * 0.1 * 20).round) / 20.0
  end
  
  def calc_import_tax(original_value)
    ((original_value.to_f * 0.05 * 20).round) / 20.0
  end
  
  def get_product
      puts "Please enter the product name and price:"
      gets.chop
  end
  
  def add_another_product?
      puts "Do you want to add another product? [Y/N]"
      gets.chop.upcase 
  end
  
  def get_original_value(product)
    product.split(" ").last
  end
  
  def get_quantity(product)
    product.split(" ").first.to_i
  end
end
