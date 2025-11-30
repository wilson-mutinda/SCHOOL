class SubjectService

  include SearchHelper

  def initialize(params = {})
    @params = params || {}
    @subjects = Subject.all.order(:id).to_a
    @target_param = params[:slug]
    @subject = search_subject_slug(@subjects, @target_param)
  end
  
  # create_subject
  def create_subject
    # name_param
    name_param = normalize_subject_name
    if name_param.is_a?(Hash) && name_param.key?(:errors)
      return name_param
    end

    # create_subject
    created_subject = Subject.new(
      name: name_param
    )

    if created_subject.save
      { success: true, message: "Subject created successfully!", info: created_subject }
    else
      { success: false, errors: created_subject.errors.full_messages }
    end
  end

  # view single_subject
  def single_subject
    
    if @subject.is_a?(Hash) && @subject.key?(:errors)
      return { success: false, errors: @subject }
    else
      return { success: true, info: @subject }
    end

  end

  # view all_subjects
  def all_subjects
    @all_subjects = Subject.all.order(:name).to_a
    if @all_subjects.empty?
      return { success: false, errors: "Empty List!" }
    else
      return { success: true, info: @all_subjects }
    end
  end

  # update_subject
  def update_subject

    puts "Started update---"
    # get subjects from params
    if @subject.is_a?(Hash) && @subject.key?(:errors)
      return @subject
    end

    puts "Subject object name: #{@subject.name}"

    updated_subject_name = {}

    # name_param
    name_param = @params[:name].to_s.downcase

    puts "Name param: #{name_param}"
    if name_param.present?
      # name should not exist for another record
      unique_name = search_unique_subject_name(@subjects, name_param, @subject.id)

      puts "Unique name passed: #{unique_name}"
      if unique_name.is_a?(Hash) && unique_name.key?(:errors)
        return unique_name
      end
      updated_subject_name[:name] = unique_name
    end

    puts "Passed name: #{unique_name}"

    # update_name
    updated_subject = @subject.update(updated_subject_name)

    if updated_subject
      { success: true, message: "Subject updated successfully!", info: @subject }
    else
      { success: false, errors: @subject.errors.full_messages }
    end
    
  end

  # delete_subject
  def delete_subject
    if @subject.is_a?(Hash) && @subject.key?(:errors)
      return @subject
    end

    # delete if only it had not been soft-deleted
    unless @subject.is_subject_deleted?
      @subject.delete_subject
      return { success: true, message: "Subject ##{@subject.name} has been soft deleted!"}
    else
      return { success: false, errors: "Subject ##{@subject.name} was already deleted!"}
    end
  end

  # restore_subject
  def restore_subject
    subject = Subject.all.unscoped.find { |s| s.slug == @target_param }
    unless subject
      return { success: false, errors: "Subject not found!"}
    else
      # check whether it was deleted
      unless subject.is_subject_deleted?
        return { success: false, errors: "This subject ##{subject.name} was not deleted!"}
      end
      subject.restore_subject
      return { success: true, message: "Subject ##{subject.name} restored successfully!"}
    end
  end

  private

  def normalize_update_subject_name
    name_param = @params[:name].to_s.downcase
    if name_param.present?
      # name should not exist
      existing = search_unique_subject_name(@subjects, name_param, @subject.id)
      if existing.is_a?(Hash) && existing.key?(:errors)
        return existing
      end
      existing
    end
  end

  def normalize_subject_name
    name_param = @params[:name].to_s.downcase

    if name_param.blank?
      return { errors: 'Please input subject name!'}
    end

    # name should not exist
    existing = search_unique_subject(@subjects, name_param)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    existing
  end
end