require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should require name" do
    product = Product.new
    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
  end

  test "should be valid with name" do
    product = Product.new(name: "Test Product")
    assert product.valid?
  end

  test "should have rich text description" do
    product = products(:tshirt)
    assert_respond_to product, :description
  end

  test "should have attached image" do
    product = products(:tshirt)
    assert_respond_to product, :image
  end

  test "should notify subscribers when in stock" do
    product = products(:tshirt)
    subscriber = subscribers(:david)
    product.subscribers << subscriber

    assert_difference "ActionMailer::Base.deliveries.size", 1 do
      product.update(in_stock: true)
    end
  end

  test "should not notify when already in stock" do
    product = products(:book)
    subscriber = subscribers(:david)
    product.subscribers << subscriber

    assert_no_difference "ActionMailer::Base.deliveries.size" do
      product.update(name: "Updated Book")
    end
  end
end
