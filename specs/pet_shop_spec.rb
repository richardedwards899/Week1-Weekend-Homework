require 'minitest/autorun'
require_relative '../pet_shop'

class TestPetShop < Minitest::Test

  def setup

    @customers = [
      {
        name: "Craig",
        pets: [],
        cash: 1000
      },
      {
        name: "Zsolt",
        pets: [],
        cash: 50
      }
    ]

    @new_pet = {
            name: "Boris the Younger",
            pet_type: :cat,
            breed: "Cornish Rex",
            price: 100
          }

    @pet_shop = {
        pets: [
          {
            name: "Sir Percy",
            pet_type: :cat,
            breed: "British Shorthair",
            price: 500
          },
          {
            name: "King Bagdemagus",
            pet_type: :cat,
            breed: "British Shorthair",
            price: 500
          },
          {
            name: "Sir Lancelot",
            pet_type: :dog,
            breed: "Pomsky",
            price: 1000,
          },
          {
            name: "Arthur",
            pet_type: :dog,
            breed: "Husky",
            price: 900,
          },
          {
            name: "Tristan",
            pet_type: :dog,
            breed: "Basset Hound",
            price: 800,
          },
          {
            name: "Merlin",
            pet_type: :cat,
            breed: "Egyptian Mau",
            price: 1500,
          }
        ],
        admin: {
          total_cash: 1000,
          pets_sold: 0,
        },
        name: "Camelot of Pets"
      }
  end

##########################################################

  def test_pet_shop_name
    name = pet_shop_name(@pet_shop)
    assert_equal("Camelot of Pets", name)
  end

  #In this, we fake the part of a pet_shop that we need (its name)
  #This saves us having to create a whole new pet_shop
  def test_pet_shop_name__fake_name
    fake_pet_shop = {name: "Mice and Men"}

    name = pet_shop_name(fake_pet_shop)
    assert_equal("Mice and Men", name)
  end

# --------------------------------------------

  def test_total_cash
    expected = 1000
    actual = total_cash(@pet_shop)
    
    assert_equal(expected, actual)
  end

  #We'll need to fake some data for this test
  def test_total_cash__fake_shop
    dummy_pet_store = {
      admin: {
        total_cash: -2000
      }
    }

    expected = -2000
    actual = total_cash(dummy_pet_store)
    
    assert_equal(expected, actual)
  end
# --------------------------------------------

  def test_add_or_remove_cash__add
    add_or_remove_cash(@pet_shop,10)
    
    expected = 1010
    actual = total_cash(@pet_shop)

    assert_equal(expected, actual)
  end

  def test_add_or_remove_cash__remove
    add_or_remove_cash(@pet_shop,-10)
    cash = total_cash(@pet_shop)
    assert_equal(990, cash)
  end

  #This test feels a bit contrived, since we know from the implementation logic that it won't fail.
  def test_add_or_remove_cash__zero
    add_or_remove_cash(@pet_shop, 0)
    cash = total_cash(@pet_shop)
    assert_equal(1000, cash)
  end

# --------------------------------------------
  
  def test_pets_sold

    expected = 0
    actual = pets_sold(@pet_shop)

    assert_equal(expected, actual)
  end

  #Our second test will need to create fake data
  def test_pets_sold__dummy_store

    dummy_pet_store = {
      admin: {
        pets_sold: 1
      }
    }

    expected = 1
    actual = pets_sold(dummy_pet_store)

    assert_equal(expected, actual)
  end

# --------------------------------------------

  def test_increase_pets_sold
    increase_pets_sold(@pet_shop,2)

    sold = pets_sold(@pet_shop)
    assert_equal(2, sold)
  end

  #Again, this feels a bit superfluous, as we know from the implementation logic that negative numbers will be fine.
  def test_increase_pets_sold__negative_number
    increase_pets_sold(@pet_shop,-2)

    sold = pets_sold(@pet_shop)
    assert_equal(-2, sold)
  end

# # --------------------------------------------

  def test_stock_count
    count = stock_count(@pet_shop)
    assert_equal(6, count)
  end

  def test_stock_count__dummy_store
    dummy_pet_store = {
      pets: [
        {
          name: "Sir Percy",
          pet_type: :cat,
          breed: "British Shorthair",
          price: 500
        }
      ]
    }

    count = stock_count(dummy_pet_store)
    assert_equal(1, count)
  end

  def test_stock_count__dummy_size_zero
    dummy_pet_store = {
      pets: []
    }

    count = stock_count(dummy_pet_store)
    assert_equal(0, count)
  end

# # --------------------------------------------

  def test_all_pets_by_breed__found
    pets = pets_by_breed(@pet_shop, "British Shorthair")
    assert_equal(2, pets.count)
  end

  def test_all_pets_by_breed_found__pomsky
    pets = pets_by_breed(@pet_shop, "Pomsky")
    assert_equal(1, pets.count)
  end

  def test_all_pets_by_breed__not_found
    pets = pets_by_breed(@pet_shop, "Dalmation")
    assert_equal(0, pets.count)
  end

# # --------------------------------------------

  def test_find_pet_by_name__returns_pet
    pet = find_pet_by_name(@pet_shop, "Arthur")
    assert_equal("Arthur", pet[:name])
  end

  def test_find_pet_by_name__returns_pet2
    pet = find_pet_by_name(@pet_shop, "Merlin")
    assert_equal("Merlin", pet[:name])
  end

  def test_find_pet_by_name__returns_nil
    pet = find_pet_by_name(@pet_shop, "Fred")
    assert_nil(nil, pet)
  end

# # --------------------------------------------

  def test_remove_pet_by_name
    remove_pet_by_name(@pet_shop, "Arthur")

    pet = find_pet_by_name(@pet_shop,"Arthur")
    assert_nil(nil, pet)
  end

  def test_remove_pet_by_name__unfound_returns_nil
    remove_pet_by_name(@pet_shop, "Wodney")

    pet = remove_pet_by_name(@pet_shop, "Wodney")
    assert_nil(nil, pet)
  end

# # --------------------------------------------

  def test_add_pet_to_stock
    add_pet_to_stock(@pet_shop, @new_pet)
    count = stock_count(@pet_shop)
    assert_equal(7, count)
  end

  #Tests what happens if no pets in stock - a bit superfluous?
  def test_add_pet_to_stock__dummy_store
    dummy_pet_store = {
      pets: []
    }

    add_pet_to_stock(dummy_pet_store, @new_pet)
    count = stock_count(dummy_pet_store)
    assert_equal(1, count)
  end

# # --------------------------------------------

  def test_customer_pet_count
    count = customer_pet_count(@customers[0])
    assert_equal(0, count)
  end

# Rather than create new data, we simulate the pets of a
# fictional customer
  def test_customer_pet_count__dummy_customer
    fake_customer = { 
      pets: [
        name: "Sir Percy",
        pet_type: :cat,
        breed: "British Shorthair",
        price: 500
      ]
    }

     count = customer_pet_count(fake_customer)
     assert_equal(1, count)
  end  

# # --------------------------------------------

  def test_add_pet_to_customer
     customer = @customers[1]
     add_pet_to_customer(customer, @new_pet)
     assert_equal(1, customer_pet_count(customer))
  end

  def test_add_pet_to_customer__pet_is_nil
     customer = @customers[1]
     add_pet_to_customer(customer, nil)
     assert_equal(0, customer_pet_count(customer))
  end


#   # # OPTIONAL

  def test_customer_can_afford_pet__insufficient_funds
    customer = @customers[1]
    can_buy_pet = customer_can_afford_pet(customer, @new_pet)
    assert_equal(false, can_buy_pet)
  end

  def test_customer_can_afford_pet__sufficient_funds
    customer = @customers[0]
    can_buy_pet = customer_can_afford_pet(customer, @new_pet)
    assert_equal(true, can_buy_pet)
  end

# # --------------------------------------------

#   # These are 'integration' tests so we want multiple asserts.
#   # If one fails the entire test should fail

  def test_sell_pet_to_customer__pet_found
    customer = @customers[0]
    pet = find_pet_by_name(@pet_shop,"Arthur")

    sell_pet_to_customer(@pet_shop, pet, customer)

    assert_equal(1, customer_pet_count(customer))
    assert_equal(1, pets_sold(@pet_shop))
    assert_equal(1900, total_cash(@pet_shop))
    #extra assertion!
    assert_equal(100, customer[:cash])
  end

  def test_sell_pet_to_customer__pet_not_found
    customer = @customers[0]
    pet = find_pet_by_name(@pet_shop,"Xanadu")

    sell_pet_to_customer(@pet_shop, pet, customer)

    assert_equal(0, customer_pet_count(customer))
    assert_equal(0, pets_sold(@pet_shop))
    assert_equal(1000, total_cash(@pet_shop))
    #extra assertions!
    assert_equal(1000, customer[:cash])
  end

  def test_sell_pet_to_customer__insufficient_funds
    customer = @customers[1]
    pet = find_pet_by_name(@pet_shop,"Arthur")

    sell_pet_to_customer(@pet_shop, pet, customer)

    assert_equal(0, customer_pet_count(customer))
    assert_equal(0, pets_sold(@pet_shop))
    assert_equal(1000, total_cash(@pet_shop))
  end

end
