module ApiHelpers
  def json_response(object, status = :ok)
    render json: object, status:
  end

  def json_error(message, status = :unprocessable_entity)
    render json: { error: message }, status:
  end
end
