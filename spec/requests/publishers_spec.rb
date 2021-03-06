 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/publishers", type: :request do
  
  # Publisher. As you add validations to Publisher, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Publisher.create! valid_attributes
      get publishers_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      publisher = Publisher.create! valid_attributes
      get publisher_url(publisher)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_publisher_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      publisher = Publisher.create! valid_attributes
      get edit_publisher_url(publisher)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Publisher" do
        expect {
          post publishers_url, params: { publisher: valid_attributes }
        }.to change(Publisher, :count).by(1)
      end

      it "redirects to the created publisher" do
        post publishers_url, params: { publisher: valid_attributes }
        expect(response).to redirect_to(publisher_url(Publisher.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Publisher" do
        expect {
          post publishers_url, params: { publisher: invalid_attributes }
        }.to change(Publisher, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post publishers_url, params: { publisher: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested publisher" do
        publisher = Publisher.create! valid_attributes
        patch publisher_url(publisher), params: { publisher: new_attributes }
        publisher.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the publisher" do
        publisher = Publisher.create! valid_attributes
        patch publisher_url(publisher), params: { publisher: new_attributes }
        publisher.reload
        expect(response).to redirect_to(publisher_url(publisher))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        publisher = Publisher.create! valid_attributes
        patch publisher_url(publisher), params: { publisher: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested publisher" do
      publisher = Publisher.create! valid_attributes
      expect {
        delete publisher_url(publisher)
      }.to change(Publisher, :count).by(-1)
    end

    it "redirects to the publishers list" do
      publisher = Publisher.create! valid_attributes
      delete publisher_url(publisher)
      expect(response).to redirect_to(publishers_url)
    end
  end
end
