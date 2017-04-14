def pet_shop_name(pet_shop)
  return pet_shop[:name]
end

def total_cash(pet_shop)
  return pet_shop[:admin][:total_cash]
end

def add_or_remove_cash(pet_shop, amount)
  pet_shop[:admin][:total_cash] += amount
end

def pets_sold(pet_shop)
  return pet_shop[:admin][:pets_sold]
end

def increase_pets_sold(pet_shop, number_sold)
  pet_shop[:admin][:pets_sold] += number_sold
end

def stock_count(pet_shop)
  return pet_shop[:pets].size()
end

#returns an array of pets of breed_name
def pets_by_breed(pet_shop, breed_name)
  selected_pets = []

  for pet in pet_shop[:pets]
    selected_pets.push(pet) if pet[:breed] == breed_name
  end

  return selected_pets
end

#returns a pet with name of pet_name
def find_pet_by_name(pet_shop, pet_name) 
  # fake_pet = {}
  # fake_pet[:name] = "Arthur" 
  # return fake_pet

  #for each pet, check if its name is pet_name
  for pet in pet_shop[:pets]
    if pet[:name] == pet_name
      return pet
    end
  end
  return nil
end

#remove pet called pet_name from pet_shop
def remove_pet_by_name(pet_shop, pet_name) 

  for pet in pet_shop[:pets]
    if pet[:name] == pet_name
      pet_shop[:pets].delete(pet)
    end
  end
  return nil
end

#adds new_pet to pet_shop
def add_pet_to_stock(pet_shop, new_pet)
  pet_shop[:pets].push(new_pet)
  return nil
end

#returns the number of pets of customer
def customer_pet_count(customer)
  return customer[:pets].length
end

#adds pet to customer
def add_pet_to_customer(customer, pet)
  customer[:pets].push(pet)
  return nil
end

################# Optional ##################

#returns true if customer can afford pet, else false
def customer_can_afford_pet(customer, pet)

  return true if customer[:cash] >= pet[:price]
  return false
end

#adds pet to customer's pets 
#increments pet_shop's pets sold counter
#increments pet shop's bank account
#decrements customer's bank account - extra!
def sell_pet_to_customer(pet_shop, pet, customer)
  
  if ( pet != nil && customer_can_afford_pet(customer, pet))
    customer[:pets].push(pet)
    pet_shop[:admin][:pets_sold] += 1

    price_of_pet = pet[:price]
    pet_shop[:admin][:total_cash] += price_of_pet

    customer[:cash] -= price_of_pet
  end

end









