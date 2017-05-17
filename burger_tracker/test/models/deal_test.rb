require 'test_helper'

class DealTest < ActiveSupport::TestCase
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
    }
    @burger1 = Burger.new(options4)
    @burger1.save
    options5 = {
      'description' => "Boring Ordinary",
      'price' => 799,
      'restaurant_id' => @restaurant3.id,
    }
    @burger2 = Burger.new(options5)
    @burger2.save

    options6 = {
      'label' => "Big Opening 2 for 1",
      'burgers' => [@burger1, @burger2],
      'start_date' => "2017-03-02",
      'restaurant_id' => @restaurant3.id,      # may be redundant info as inherited from burgers
      'discount_rate' => 0.5,
      'money_off' => 0
    }
    @deal1 = Deal.new(options6)

    end

    def test_deal_has_params
      assert_equal('Big Opening 2 for 1', @deal1.label )
      assert_equal(@restaurant3.id, @deal1.restaurant_id )
      assert_equal([@burger1, @burger2], @deal1.burgers )
      date = Date.parse("2017-03-02")
      assert_equal(date, @deal1.start_date)
    end

end
