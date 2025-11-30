class Api::V1::SubjectsController < ApplicationController

  # create_subject
  def create_subject
    begin
      service = SubjectService.new(subject_params)
      result = service.create_subject
      if result[:success]
        render json: result[:info], serializer: SubjectSerializer , status: :created
      else
        render json: {errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: 'Something went wrong!', message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_subject
  def single_subject
    begin
      service = SubjectService.new(slug: params[:slug])
      result = service.single_subject
      if result[:success]
        render json: result[:info], serializer: SubjectSerializer, status: :ok
      else
        render json: result[:errors], status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view all_subjects
  def all_subjects
    begin
      service = SubjectService.new
      result = service.all_subjects
      if result[:success]
        render json: result[:info], each_serializer: SubjectSerializer, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_subject
  def update_subject
    begin
      service = SubjectService.new(subject_params.merge(slug: params[:slug]))
      result = service.update_subject
      if result[:success]
        render json: result[:info], serializer: SubjectSerializer, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Somethiong went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_subject
  def delete_subject
    begin
      service = SubjectService.new(slug: params[:slug])
      result = service.delete_subject
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_subject
  def restore_subject
    begin
      service = SubjectService.new(slug: params[:slug])
      result = service.restore_subject
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold subject_params
  private
  def subject_params
    params.require(:subject).permit(:name)
  end
end
