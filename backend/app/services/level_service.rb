class LevelService

  include SearchHelper

  def initialize(params = {})
    @params = params || {}
    @levels = Level.all.order(:id).to_a
    @target_param = params[:slug]
  end

  # create_level
  def create_level
    # name_param
    name_param = normalize_level_name
    if name_param.is_a?(Hash) && name_param.key?(:errors)
      return name_param
    end

    # stream_id
    stream_id_param = normalize_level_stream_id
    if stream_id_param.is_a?(Hash) && stream_id_param.key?(:errors)
      return stream_id_param
    end

    # create_level
    created_level = Level.new(
      name: name_param,
      stream_id: stream_id_param
    )

    if created_level.save
      { success: true, message: "Level created successfully!", info: created_level }
    else
      { success: false, errors: name_param.errors.full_messages }
    end
  end

  # view single_level
  def single_level
    @level = search_level_slug(@levels, @target_param)
    if @level.is_a?(Hash) && @level.key?(:errors)
      return { success: false, errors: @level }
    else
      return { success: true, info: @level }
    end
  end

  # view all_levels
  def all_levels
    levels = Level.all.order(:name).to_a
    if levels.empty?
      return { success: false, errors: 'Empty List!'}
    else
      return { success: true, info: levels }
    end
  end

  # update_level
  def update_level
    @level = search_level_slug(@levels, @target_param)
    if @level.is_a?(Hash) && @level.key?(:errors)
      return { success: false, errors: @level }
    end

    updated_level_params = {}

    if @params.key?(:name)
      # level_name_param
      level_name_param = normalize_update_level_name
      if level_name_param.is_a?(Hash) && level_name_param.key?(:errors)
        return level_name_param
      end
      updated_level_params[:name] = level_name_param
    end

    if @params.key?(:stream_id)
      # stream_id_param
      stream_id_param = normalize_update_stream_id
      if stream_id_param.is_a?(Hash) && stream_id_param.key?(:errors)
        return stream_id_param
      end
      updated_level_params[:stream_id] = stream_id_param
    end

    # update_level
    updated_level = @level.update(updated_level_params)

    if updated_level
      { success: true, message: 'Level updated successfully', info: @level }
    else
      { success: false, errors: @level.errors.full_messages }
    end
  end

  # delete_level
  def delete_level
    @level = search_level_slug(@levels, @target_param)
    if @level.is_a?(Hash) && @level.key?(:errors)
      return { success: false, errors: @level }
    end

    # delete level if only it was not deleted
    if @level.level_deleted?
      return { success: false, errors: 'Level has already been deleted!'}
    else
      @level.delete_level
      return { success: true, message: 'Level soft deleted successfully!'}
    end
  end

  # restore_level
  def restore_level
    level = Level.find { |l| l.slug == @target_param }
    if level
      if !level.level_deleted?
        return { success: false, errors: 'Level was not deleted!'}
      else
        level.restore_level
        return { success: true, message: 'Level restored successfully!'}
      end
    else
      return { success: false, errors: 'Level does not exist!'}
    end
  end

  private

  def normalize_update_stream_id
    stream_id_param = @params[:stream_id].to_i
    if stream_id_param.present?
      # check if stream exists
      existing = Stream.find { |s| s.id == stream_id_param }
      if !existing
        return { success: false, errors: 'Stream not found!'}
      else
        return stream_id_param
      end
    end
  end

  def normalize_update_level_name
    name_param = @params[:name].to_i
    if name_param.present?
      # level should not exist
      existing = search_unique_level(@levels, @target_param, @level.id)
      if existing.is_a?(Hash) && existing.key?(:errors)
        return existing
      end
      name_param
    end
  end

  def normalize_level_name
    name_param = @params[:name].to_i
    if name_param.blank?
      return { errors: 'Please input level!'}
    end

    # level should not exist
    existing = unique_level_name(@levels, name_param)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    existing
  end

  def normalize_level_stream_id
    stream_id = @params[:stream_id].to_i
    if stream_id.blank?
      return { errors: 'Please select stream!'}
    end

    # check if stream exists
    existing = Stream.find { |s| s.id == stream_id }
    if !existing
      return { errors: 'Stream not found!'}
    else
      return existing.id
    end
  end
end