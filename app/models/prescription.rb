class Prescription < ActiveRecord::Base 
    belongs_to :patient
    belongs_to :appointment

    def self.prescriptions_for_a_patient_with(patient_id)
        self.find_by(patient_id: patient_id)
    end

    
end