class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons
  
  include RankedModel
  ranks :row_order, with_same: :course_id
  
  def next_section
    section = course.sections.where("row_order > ?", self.row_order).rank(:row_order).first
    if section.blank? && course.next_course
      return course.next_course.sections.rank(:row_order).first
    end
    return section
  end

end
