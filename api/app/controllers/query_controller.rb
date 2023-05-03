class QueryController < ApplicationController
  def query
    if params[:query].blank?
      return render(status: :bad_request, json: {error: "Missing query parameter"})
    end

    render(status: :ok, json: {error: nil, response: params[:query]})
  end
end
