require_relative "../shopping_basket"

RSpec.describe do
  describe "Shopping Basket" do
    it "can process an entity" do
      allow_any_instance_of(ShoppingBasket).to receive(:gets).and_return("1 Book at 10.00\n", "N\n")
      expect { ShoppingBasket.new.run }.to output(/1 Book: 10.0/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/Sales Taxes: 0/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/Total: 10.0/).to_stdout
    end

    it "can pass Input 1" do 
      allow_any_instance_of(ShoppingBasket).to receive(:gets).and_return(
        "2 book at 12.49\n", 
        "Y\n",
        "1 music CD at 14.99\n",
        "Y\n",
        "1 chocolate bar at 0.85\n",
        "N\n"
      )
      expect { ShoppingBasket.new.run }.to output(/2 book: 24.98/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/1 music CD: 16.49/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/1 chocolate bar: 0.85/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/Sales Taxes: 1.5/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/Total: 42.32/).to_stdout
    end

    it "can pass Input 2" do 
      allow_any_instance_of(ShoppingBasket).to receive(:gets).and_return(
        "1 imported box of chocolates at 10\n", 
        "Y\n",
        "1 imported bottle of perfume at 47.50\n",
        "N\n",
      )
      expect { ShoppingBasket.new.run }.to output(/1 imported box of chocolates: 10.5/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/1 imported bottle of perfume: 54.65/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/Sales Taxes: 7.65/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/Total: 65.15/).to_stdout
    end

    it "can pass Input 3" do 
      allow_any_instance_of(ShoppingBasket).to receive(:gets).and_return(
        "1 imported bottle of perfume at 27.99\n",
        "Y\n",
        "1 bottle of perfume at 18.99\n",
        "Y\n",
        "1 packet of headache pills at 9.75\n",
        "Y\n",
        "3 imported boxes of chocolates at 11.25\n", 
        "N\n",
      )
      expect { ShoppingBasket.new.run }.to output(/1 imported bottle of perfume: 32.19/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/1 bottle of perfume: 20.89/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/1 packet of headache pills: 9.75/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/3 imported boxes of chocolates: 35.4/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/Sales Taxes: 7.75/).to_stdout
      expect { ShoppingBasket.new.run }.to output(/Total: 98.23/).to_stdout
    end
  end
end