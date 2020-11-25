class User < ActiveRecord::Base 
    has_secure_password

    def is_patient? 
        !!self.patient_id
    end
end