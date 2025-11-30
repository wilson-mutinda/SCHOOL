class StreamService

  include SearchHelper

  def initialize(params = {})
    @params = params || {}
    @streams = Stream.all.order(:id).to_a
    @target_param = params[:slug]
  end

  # create_stream
  def create_stream
    # name_param
    name_param = normalize_name
    if name_param.is_a?(Hash) && name_param.key?(:errors)
      return name_param
    end

    # create_name
    created_name = Stream.new(
      name: name_param
    )

    if created_name.save
      return { success: true, message: "Name created successfully!", info: created_name }
    else
      return { success: false, errors: created_name.errors.full_messages }
    end
  end

  # view single_stream
  def single_stream
    @stream = search_stream_slug(@streams, @target_param)
    if @stream.is_a?(Hash) && @stream.key?(:errors)
      { success: false, errors: @stream }
    else
      { success: true, info: @stream }
    end
  end

  # view all_streams
  def all_streams
    streams = Stream.all.order(:name).to_a
    if streams.empty?
      { success: false, errors: 'No streams found!'}
    else
      { success: true, info: streams }
    end
  end

  # update_stream
  def update_stream
    @stream = search_stream_slug(@streams, @target_param)
    if @stream.is_a?(Hash) && @stream.key?(:errors)
      return @stream
    end

    # name_param
    if @params.key?(:name)
      name_param = normalize_update_name
      if name_param.is_a?(Hash) && name_param.key?(:errors)
        return name_param
      end

      # update_name
      updated_name = @stream.update(
        name: name_param
      )

      if updated_name
        { success: true, info: @stream, message: "Stream updated successfully!" }
      else
        { success: false, errors: @stream.errors.full_messages }
      end
    end
  end

  # delete_stream
  def delete_stream
    @stream = search_stream_slug(@streams, @target_param)
    if @stream.is_a?(Hash) && @stream.key?(:errors)
      return @stream
    end

    # soft delete stream
    
    # check if stream was deleted first
    if @stream.soft_deleted?
      return { success: false, errors: 'Stream has already been deleted!'}
    else
      @stream.soft_delete
      return { success: true, message: 'Stream deleted successfully!'}
    end
  end

  # restore_stream
  def restore_stream
    stream = Stream.all.unscoped.find { |s| s.slug == @target_param }
    if stream
      if !stream.soft_deleted?
        { success: false, errors: 'Stream was not deleted!'}
      else
        stream.restore_stream
        { success: true, message: 'Stream has been restored successfully!'}
      end
    else
      { success: false, errors: 'Stream dies not exist!'}
    end
  end

  private

  def normalize_update_name
    name_param = @params[:name].to_s.gsub(/\s+/, '').downcase
    if name_param.present?
      # name should not exist
      existing = search_unique_name(@streams, name_param, @stream.id)
      if existing.is_a?(Hash) && existing.key?(:errors)
        return existing
      end
      existing.capitalize
    end
  end

  def normalize_name
    # name_param
    name_param = @params[:name].to_s.gsub(/\s+/, '').downcase
    if name_param.blank?
      return { errors: 'Please input stream name!'}
    end

    # name should not exist
    existing = unique_stream_name(@streams, name_param)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    existing.capitalize
  end
end