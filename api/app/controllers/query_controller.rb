class QueryController < ApplicationController
  def query
    return render(status: :bad_request, json: { error: 'Missing query parameter' }) if params[:query].blank?

    render status: :ok, json: { error: nil, response: params[:query] }
  end
end
