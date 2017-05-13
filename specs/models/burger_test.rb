require 'test_helper'

class BurgerTest < ActiveSupport::TestCase
  
  test "the truth" do
    assert true
  end
  
  def setup
    options1 = {
      'street_addr' => '21',
      'street' => 'Lothian Road',
      'area' => '',
      'city' => 'Edinburgh',
      'post_code' => 'EH1 2AB',
      'phone_no' => '+44 1234 567890'
    }
    @address1= Address.new(options1)
    options2 = {
      'street_addr' =>'22',
      'street' =>'Lothian Road',
      'area' =>'',
      'city' =>'Edinburgh',
      'post_code' =>'EH1 2AB',
      'phone_no' => '+44 1234 567891'
    }
    @address2 = Address.new(options2)
    @address1.save
    @address2.save
    options3 = {
      'name' => "Big Kahuna",
      'address_id' =>  @address1.id
    }
    @restaurant3 = Restaurant.new(options3)
    @restaurant3.save

    options4 = {
      'description' => "Big Kahuna with cheese",
      'price' => 999,
      'restaurant_id' => @restaurant3.id,
      'rating' => 3
    }
    
    @burger1 = Burger.new(options4)
  end

  def test_burger_has_params
    
    assert_equal(999, @burger1.price )
    assert_equal(@restaurant3.id, @burger1.restaurant_id )
    assert_equal(3, @burger1.rating )
  end

  def test_can_do_currency_arithmetic
    # check currency arithmetic with BigDecimal type
    assert_equal(1998 , (@burger1.price * 2)  )
    assert_equal(499.5 , (@burger1.price) / 2 )
    assert_equal(99 , (@burger1.price % 900).to_f )
  end

  def test_has_id_after_save
    assert_equal(true,  @burger1.id == nil )
    @burger1.save
    assert_equal(true,  @burger1.id.is_a?(Fixnum) && @burger1.id != 0 )
  end  
end
