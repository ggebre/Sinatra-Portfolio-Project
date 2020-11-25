class Comment < ActiveRecord::Base
    belongs_to :patient
    belongs_to :staff

    # def self.comments_by_a_patient_with(patient_id)
    #     self.select{|comment| comment.patient_id == patient_id}

    # end

    # def self.comments_to_a_staff_with(staff_id)
    #     self.select{|comment| comment.staff_id == staff_id}
    # end
end

