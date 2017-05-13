require 'test_helper'
# include Devise::Test::ControllerHelpers

class AddressTest < ActiveSupport::TestCase

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
    @address_no_id1= Address.new(options1)
    options2 = {
      'street_addr' =>'22',
      'street' =>'Lothian Road',
      'area' =>'',
      'city' =>'Edinburgh',
      'post_code' =>'EH1 2AB',
      'phone_no' => '+44 1234 567891'
    }
    @address_no_id2 = Address.new(options2)

  end

  def test_address_has_details_no_id
    assert_equal('21', @address_no_id1.street_addr)
    assert_equal('Lothian Road', @address_no_id1.street)
    assert_equal('', @address_no_id1.area)
    assert_equal('EH1 2AB', @address_no_id1.post_code)
    assert_equal('+44 1234 567890', @address_no_id1.phone_no)
    assert_nil(@address_no_id1.id)

    assert_equal('22', @address_no_id2.street_addr)
    assert_equal('Lothian Road', @address_no_id2.street)
    assert_equal('', @address_no_id2.area)
    assert_equal('EH1 2AB', @address_no_id2.post_code)
    assert_equal('+44 1234 567891', @address_no_id2.phone_no)
    assert_nil(@address_no_id2.id)
  end

  def test_address_has_id_afer_save
    assert_equal(true,  @address_no_id1.id == nil)
    @address_no_id1.save()
    assert_equal(true,  @address_no_id1.id != 0)
    # puts "address_no_id1.id =  #{@address_no_id1.id} after save"
  end


end
