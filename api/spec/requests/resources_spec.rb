require "rails_helper"

RSpec.describe "Resources", type: :request do
  let!(:resource) {
    r = create(:resource)

    10.times do
      create(:resource_faq, resource: r)
    end

    r
  }

  describe "GET /index" do
    it "returns list of resources" do
      headers = {"ACCEPT" => "application/json"}
      get("/resources", headers: headers)

      expect(response.content_type).to(eq("application/json; charset=utf-8"))

      body = JSON.parse(response.body)
      expect(body.size).to(eq(1))
      expect(body[0].keys.sort).to(eq(["slug", "name"].sort))
    end
  end

  describe "GET /:slug" do
    it "returns resource with faqs" do
      headers = {"ACCEPT" => "application/json"}
      get("/resources/#{resource.slug}", params: {slug: resource.slug}, headers: headers)

      expect(response.content_type).to(eq("application/json; charset=utf-8"))

      body = JSON.parse(response.body)
      expect(body.keys.sort).to(eq(["slug", "name", "summary", "faqs"].sort))
      expect(body["faqs"].size).to(eq(5))
    end
  end
end
