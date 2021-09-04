class AuthorsController < ApplicationController
  # added rescue_from
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    author = Author.find(params[:id])

    render json: author
  end

  def create
    author = Author.create!(author_params)
    # create! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code    
    render json: author, status: :created
  end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

end
