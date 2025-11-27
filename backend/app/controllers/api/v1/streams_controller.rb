class Api::V1::StreamsController < ApplicationController

  # create_stream
  def create_stream
    begin
      service = StreamService.new(stream_params)
      result = service.create_stream
      if result[:success]
        render json: { message: result[:message], info: result[:info]}, status: :created
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: 'Something went wrong!', message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_stream
  def single_stream
    begin
      service = StreamService.new(slug: params[:slug])
      result = service.single_stream
      if result[:success]
        render json: result[:info], serializer: StreamSerializer, status: :ok
      else
        render json: result[:errors], status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: 'Something went wrong!', message: e.message }, status: :internal_server_error
    end
    
  end

  # view all_streams
  def all_streams
    begin
      service = StreamService.new
      result = service.all_streams
      if result[:success]
        render json: result[:info], each_serializer: StreamSerializer, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: 'Something went wrong!', message: e.message }, status: :internal_server_error
    end
    
  end

  # update_stream
  def update_stream
    begin
      service = StreamService.new(stream_params.merge(slug: params[:slug]))
      result = service.update_stream
      if result[:success]
        render json:  result[:info], serializer: StreamSerializer, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_stream
  def delete_stream
    begin
      service = StreamService.new(slug: params[:slug])
      result = service.delete_stream
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: 'Something went wrong!', message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_stream
  def restore_stream
    begin
      service = StreamService.new(slug: params[:slug])
      result = service.restore_stream
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: 'Something went wrong!', message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold stream_params
  private
  def stream_params
    params.require(:stream).permit(:name)
  end
end
