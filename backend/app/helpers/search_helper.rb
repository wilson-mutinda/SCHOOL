module SearchHelper
  def unique_stream_name(streams, name_param)
    name_param = name_param.to_s.gsub(/\s+/, '').downcase

    first_index = 0;
    last_index = streams.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_stream = streams[mid_index]

      if mid_stream.name.downcase == name_param
        return { 'errors': 'Stream name already exists!'}
      elsif mid_stream.name.downcase < name_param
        first_index = mid_index + 1
      else
        last_index = mid_index - 1
      end
    end
    name_param
  end

  def search_stream_slug(streams, slug)
    slug = slug.to_s.gsub(/\s+/, '').downcase

    # check if slug is an ID
    if slug.match?(/\A\d+\z/)
      slug = slug.to_i

      first_index = 0;
      last_index = streams.length - 1;

      while first_index <= last_index
        mid_index = (first_index + last_index) / 2;
        mid_stream = streams[mid_index]

        if mid_stream.id == slug
          return mid_stream
        elsif mid_stream.id < slug
          first_index = mid_index + 1
        else
          last_index = mid_index - 1
        end
      end

      return { errors: "Stream not found for ID #{slug}"}
    end

    # search by name
    result = streams.find { |s| s.name.downcase == slug || s.slug.downcase == slug }
    return { errors: "Stream not found for #{slug}"} unless result
    result 
  end

  def search_unique_name(streams, target_param, current_id)
    target_param = target_param.to_s.gsub(/\s+/, '').downcase

    first_index = 0;
    last_index = streams.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_stream = streams[mid_index]

      if mid_stream.name.downcase == target_param
        if mid_stream.id != current_id
          return { errors: 'Name already exists!'}
        else
          return mid_stream.name.downcase
        end
      elsif mid_stream.name.downcase < target_param
        first_index = mid_index + 1
      else
        last_index = mid_index - 1
      end
    end

    target_param
  end

  def unique_level_name(levels, target_param)
    target_param = target_param.to_i

    first_index = 0;
    last_index = levels.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2
      mid_level = levels[mid_index]

      if mid_level.name.to_i == target_param
        return { errors: 'This level already exists!'}
      elsif mid_level.name.to_i < target_param
        first_index = mid_index + 1
      else
        last_index = mid_index - 1
      end
    end
    target_param
  end

  def search_level_slug(levels, slug)
    slug = slug.to_i

    result = levels.find { |l| l.id == slug || l.name.to_i == slug || l.slug.to_s == slug.to_s }
    if result
      return result
    else
      return { errors: "Level not found for #{slug}"}
    end
  end

  def search_unique_level(levels, target_param, current_id)
    target_param = target_param.to_i

    first_index = 0;
    last_index = levels.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_level = levels[mid_index]

      if mid_level.name.to_i == target_param
        if mid_level.id != current_id
          return { errors: 'This level already exists!'}
        else
          return mid_level.name
        end
      elsif mid_level.name.to_i < target_param
        first_index = mid_index + 1
      else
        last_index = mid_index - 1
      end
    end
    target_param
  end

end