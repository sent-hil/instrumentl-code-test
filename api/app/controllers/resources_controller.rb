class ResourcesController < ApplicationController
  def index
    resources = Resource.order(:created_at).limit(5)
    render(json: resources.to_json(only: [:slug, :name]))
  end

  def show
    resource = Resource
      .includes(:faqs)
      .where(slug: params[:slug])
      .first

    render(json: resource.to_json(only: [:slug, :name, :summary], include: :faqs))
  end
end
