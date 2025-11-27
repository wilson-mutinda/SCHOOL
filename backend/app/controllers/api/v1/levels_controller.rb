class Api::V1::LevelsController < ApplicationController

  # create_level
  def create_level
    begin
      service = LevelService.new(level_params)
      result = service.create_level
      if result[:success]
        render json: { message: result[:message], info: LevelSerializer.new(result[:info])}, status: :created
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # single_level
  def single_level
    begin
      service = LevelService.new(slug:params[:slug])
      result = service.single_level
      if result[:success]
        render json: result[:info], serializer: LevelSerializer, status: :ok
      else
        render json: result[:errors], status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # all_levels
  def all_levels
    begin
      service = LevelService.new
      result = service.all_levels
      if result[:success]
        render json: result[:info], each_serializer: LevelSerializer, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_level
  def update_level
    begin
      service = LevelService.new(level_params.merge(slug: params[:slug]))
      result = service.update_level
      if result[:success]
        render json: {
          message: result[:message],
          info: LevelSerializer.new(result[:info])
        }, status: :ok
      else
        render json: {errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: 'Something went wrong!', message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_level
  def delete_level
    begin
      service = LevelService.new(slug: params[:slug])
      result = service.delete_level
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_level
  def restore_level
    begin
      service = LevelService.new(slug: params[:slug])
      result = service.restore_level
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Somethong went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold level_params
  private
  def level_params
    params.require(:level).permit(:name, :stream_id)
  end
end
