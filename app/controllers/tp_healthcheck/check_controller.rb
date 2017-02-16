# frozen_string_literal: true
class TPHealthcheck::CheckController < ActionController::API
  include TPHealthcheck::DataBaseHelper
  rescue_from StandardError, with: :handle_exception

  def show
    unless self.class.private_method_defined?(params[:cmd].to_sym)
      return render json: { url: 'url not found' }.to_json, status: :not_found
    end
    send(params[:cmd])
  end

  private

  def ping
    render plain: Rails.application.class.parent.to_s, status: :ok
  end

  def database
    unless database_on?
      return render json: { code: '01', msg: 'database error' }.json, status: :internal_server_error
    end
    render plain: 'OK', status: :ok
  end

  def handle_exception(ex)
    Rails.logger.info("handle_exception:#{ex}")
    render nothing: true, status: :internal_server_error
  end
end
