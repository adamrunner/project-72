class EntriesController < ApiController
  include DefaultMethods
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  skip_forgery_protection only: :create

  def index
    default_sort_by :updated_at, :desc
    @entries = Entry.
      page(params[:page]).
      per(params[:per_page]).
      order_by([params[:sort], params[:order]])
    render json: {entries: @entries}, status: :ok
  end

  def create
    if @entry = Entry.create(entry_params)
      # broadcast_message
      render json: {entry: @entry}, status: :ok
    else
      render json: {entry: @entry, errors: @entry.errors}, status: 422
    end
  end

  def show
    if @entry.present?
      render json: {entry: @entry}, status: :ok
    else
      render json: {entry: nil}, status: 404
    end
  end

  def update
    if @entry.update_attributes(entry_params)
      render json: {entry: @entry}, status: :ok
    else
      render json: {entry: @entry, errors: @entry.errors}, status: 422
    end
  end

  def destroy
    if @entry.destroy
      render head :no_content
    else
      render json: {errors: @entry.errors }, status: 422
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # def broadcast_message
  #   # TODO: see if we need to move this elsewhere for transmitting the message
  #   ActionCable.server.broadcast('dashboard_channel', @entry.sensor.as_json)
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    # TODO: require hostname
    params.require(:entry).permit(
      :_id,
      :created_at,
      :hostname,
      :battery,
      :voltage,
      :temp,
      :humidity,
      :heat_index
    ).merge(sensor_id: sensor_id)
  end

  def sensor_id
    Sensor.find_or_create_by(hostname: params[:hostname]).id
  end
end