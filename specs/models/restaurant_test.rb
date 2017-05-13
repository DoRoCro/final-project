require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

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
  end

  def test_new_can_create_with_params
    options3 = {
      'name' => "Big Kahuna",
      'address_id' =>  @address1.id
    }
    restaurant3 = Restaurant.new(options3)
    assert_equal('Big Kahuna', restaurant3.name)
    assert_equal(@address1.id, restaurant3.address_id)
    assert_equal(true, restaurant3.id == nil)
    restaurant3.save
    assert_equal(true, restaurant3.id.is_a?(Fixnum) && restaurant3.id != 0)

  end

end
