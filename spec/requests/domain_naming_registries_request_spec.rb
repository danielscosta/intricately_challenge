require "rails_helper"

RSpec.describe "DomainNamingRegistries", type: :request do
  # initialize test data
  let!(:domain_naming_registries) { create_list(:domain_naming_registry, 10) }
  let!(:domain_naming_registry) { domain_naming_registries.first }

  describe "GET /domain_naming_registries" do
    context "when the record is into included query params" do
      before { get "/domain_naming_registries/", params: { page: 1, included: [domain_naming_registry.hostnames_attributes.first], excluded: nil } }

      it "returns the domain_naming_registries" do
        expect(json).not_to be_empty
        expect(json["total_records"]).to eq(1)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record is into excluded query params" do
      before { get "/domain_naming_registries/", params: { page: 1, included: nil, excluded: [domain_naming_registry.hostnames_attributes.first] } }

      it "returns the domain_naming_registries" do
        expect(json).not_to be_empty
        expect(json["total_records"]).to eq(9)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      before { get "/domain_naming_registries/", params: { page: 1, included: [Faker::Internet.domain_name], excluded: nil } }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Domain/)
      end
    end
  end

  describe "POST /domain_naming_registries" do
    let(:valid_attributes) { { ip: Faker::Internet.ip_v4_address, hostnames_attributes: [Faker::Internet.domain_name, Faker::Internet.domain_name] } }

    context "when the request is valid" do
      before { post "/domain_naming_registries", params: valid_attributes }

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post "/domain_naming_registries", params: { ip: Faker::Internet.ip_v4_address } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match(/Hostnames attributes can't be blank, Hostnames attributes Should have a least one hostname/)
      end
    end
  end
end
