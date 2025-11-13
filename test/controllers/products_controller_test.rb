require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:david)
    @product = products(:tshirt)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new when logged in" do
    post login_path, params: { email_address: @user.email_address, password: "password123" }
    get new_product_url
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_product_url
    assert_redirected_to login_path
  end

  test "should create product when logged in" do
    post login_path, params: { email_address: @user.email_address, password: "password123" }

    assert_difference("Product.count") do
      post products_url, params: { product: { name: "New Product", in_stock: false } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should not create product without name" do
    post login_path, params: { email_address: @user.email_address, password: "password123" }

    assert_no_difference("Product.count") do
      post products_url, params: { product: { name: "", in_stock: false } }
    end

    assert_response :unprocessable_entity
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit when logged in" do
    post login_path, params: { email_address: @user.email_address, password: "password123" }
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product when logged in" do
    post login_path, params: { email_address: @user.email_address, password: "password123" }

    patch product_url(@product), params: { product: { name: "Updated Product" } }
    assert_redirected_to product_url(@product)

    @product.reload
    assert_equal "Updated Product", @product.name
  end

  test "should destroy product when logged in" do
    post login_path, params: { email_address: @user.email_address, password: "password123" }

    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "should not destroy product when not logged in" do
    assert_no_difference("Product.count") do
      delete product_url(@product)
    end

    assert_redirected_to login_path
  end
end
